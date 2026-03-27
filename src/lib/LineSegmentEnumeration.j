library LineSegmentEnumeration /* v2.2a -- hiveworkshop.com/threads/line-segment-enumeration-v1-1.286552/

    Information
    ¯¯¯¯¯¯¯¯¯¯¯

        Allows to enumerate widgets inside a line segment with an offset.
        So basicly it will result in a rect, but which is also allowed to be rotated.
     
     
    Mechanics
    ¯¯¯¯¯¯¯¯¯
     
        (Issue:)
     
        The problem with normal jass rects is that they aren't defined by 4 points, but only by 4 values: x/y -min/max.
        The result is that a jass rect is never rotated, so it's always paralel to the x/y axis.
     
        But when we draw a line from point A to point B we might also create a non-axix-parelel rect, and then
        we can't use the normal rect natives from jass anymore to find out if a point is inside the rect.

        (Solution:)
     
        To solve this problem the system does following:
     
        jass rect: rectangular defined by 4 values (axis paralel)
        custom rect: the real rectangular that is defined by user (not axis parelel)

        1. Create a big jass rect that is big enough so we can ensure to enum all widgets that are potentialy inside our custom rect. (Enum_Group)
           This Enum_Group will contain all wanted units, but may also contain not wanted units.

        2. Construct the custom rect following a form with the same parameters as in this image, but in 2D:
           https://upload.wikimedia.org/wikipedia/commons/thumb/3/33/Ellipsoide.svg/800px-Ellipsoide.svg.png

        3. Loop through Enum_Group and define each widget's coordinates relative to the center of the custom rect as a 2D vector

        4. Get the components of the widget's position vector on the local (rotated) x-y axis of the custom rect

        5. Check if the projected lengths (absolute value of components) of the widget's position is less than <a> and <b> as described in the
           image linked above.

*/
//  --- API ---
//! novjass

    struct LineSegment

        static constant real MAX_UNIT_COLLISION
 
        static method EnumUnitsEx takes group whichgroup, real ax, real ay, real bx, real by, real offset, boolean checkCollision returns nothing
        static method EnumUnits takes group whichgroup, real ax, real ay, real bx, real by, real offset returns nothing
 
        static method EnumDestructables takes real ax, real ay, real bx, real by, real offset returns nothing
         
        //  after enumerated destructables you have access to:
     
            static integer DestructableCounter      // starts with index "0"
            static destructable array Destructable
         
        static method EnumItems takes real ax, real ay, real bx, real by, real offset returns nothing
         
        //  after enumerated items you have access to:
     
            static integer ItemCounter      // starts with index "0"
            static destructable array Item
         
//! endnovjass
// ==== End API ====

    struct LineSegment extends array

        public static constant real MAX_UNIT_COLLISION = 197.00

        private static constant rect RECT = Rect(0, 0, 0, 0)

        private static constant group GROUP = CreateGroup()

        private static real ox
        private static real oy
        private static real dx
        private static real dy
        private static real da
        private static real db
        private static real ui
        private static real uj
        private static real wdx
        private static real wdy

        private static method PrepareRect takes real ax, real ay, real bx, real by, real offset, real offsetCollision returns nothing
            local real maxX
            local real maxY
            local real minX
            local real minY

            // get center coordinates of rectangle
            set ox = 0.5*(ax + bx)
            set oy = 0.5*(ay + by)

            // get rectangle major axis as vector
            set dx = 0.5*(bx - ax)
            set dy = 0.5*(by - ay)

            // get half of rectangle length (da) and height (db)
            set da = SquareRoot(dx*dx + dy*dy)
            set db = offset

            // get unit vector of the major axis
            set ui = dx/da
            set uj = dy/da

            // Prepare the bounding Jass Rect
            set offset = offset + offsetCollision

            if ax > bx then
                set maxX = ax + offset
                set minX = bx - offset
            else
                set maxX = bx + offset
                set minX = ax - offset
            endif

            if ay > by then
                set maxY = ay + offset
                set minY = by - offset
            else
                set maxY = by + offset
                set minY = ay - offset
            endif

            call SetRect(RECT, minX, minY, maxX, maxY)
        endmethod

        private static method RotateWidgetCoordinates takes widget w returns nothing
            // distance of widget from rectangle center in vector form
            set wdx = GetWidgetX(w) - ox
            set wdy = GetWidgetY(w) - oy

            set dx = wdx*ui + wdy*uj    // get the component of above vector in the rect's major axis
            set dy = wdx*(-uj) + wdy*ui // get the component of above vector in the rect's transverse axis
        endmethod

        private static method IsWidgetInRect takes widget w returns boolean
            call RotateWidgetCoordinates(w)

            // Check if the components above are less than half the length and height of the rectangle
            // (Square them to compare absolute values)
            return dx*dx <= da*da and dy*dy <= db*db
        endmethod

        private static method IsUnitInRect takes unit u, boolean checkCollision returns boolean
            if checkCollision then
                call RotateWidgetCoordinates(u)

                // Check if the perpendicular distances of the unit from both axes of the rect are less than
                // da and db
                return IsUnitInRangeXY(u, ox - dy*uj, oy + dy*ui, RAbsBJ(da)) /*
                */ and IsUnitInRangeXY(u, ox + dx*ui, oy + dx*uj, RAbsBJ(db))
            endif

            return IsWidgetInRect(u)
        endmethod

        public static method EnumUnitsEx takes group whichgroup, real ax, real ay, real bx, real by, real offset, boolean checkCollision returns nothing
            local unit u

            if checkCollision then
                call PrepareRect(ax, ay, bx, by, offset, MAX_UNIT_COLLISION)
            else
                call PrepareRect(ax, ay, bx, by, offset, 0.00)
            endif

            call GroupEnumUnitsInRect(GROUP, RECT, null)

            // enum through all tracked units, and check if it's inside bounds
            call GroupClear(whichgroup)
            loop
                set u = FirstOfGroup(GROUP)
                exitwhen u == null

                if IsUnitInRect(u, checkCollision) then
                    call GroupAddUnit(whichgroup, u)
                endif

                call GroupRemoveUnit(GROUP, u)
            endloop
        endmethod

        public static method EnumUnits takes group whichgroup, real ax, real ay, real bx, real by, real offset returns nothing
            call EnumUnitsEx(whichgroup, ax, ay, bx, by, offset, false)
        endmethod

    //! textmacro LSE_WIDGET takes TYPE, NAME
        public static integer $NAME$Counter = -1
        public static $TYPE$ array $NAME$
     
        private static method on$NAME$Filter takes nothing returns nothing
            local $TYPE$ t = GetFilter$NAME$()

            if IsWidgetInRect(t) then
                set $NAME$Counter = $NAME$Counter + 1
                set $NAME$[$NAME$Counter] = t
            endif

            set t = null
        endmethod
     
        public static method Enum$NAME$s takes real ax, real ay, real bx, real by, real offset returns nothing
            call PrepareRect(ax, ay, bx, by, offset, 0.00)

            set $NAME$Counter = -1
            call Enum$NAME$sInRect(RECT, Filter(function thistype.on$NAME$Filter), null)
        endmethod
    //! endtextmacro

    //! runtextmacro LSE_WIDGET("destructable", "Destructable")
    //! runtextmacro LSE_WIDGET("item", "Item")
     
    endstruct
endlibrary
