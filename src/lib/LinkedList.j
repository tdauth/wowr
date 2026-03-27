//! novjass
|-------------------|
| API Documentation |
|-------------------|
/*
    v1.3.0
    LinkedList library

        If you are looking for a comprehensive listing of API available for each module, see the header of the
        library itself. What you can find here is the description of ALL avaiable API.

        The library supports 4 different implementations of linked-list:
            - Free lists, where you have freedom in linking and dealing with nodes
              without being restricted by the concept of a 'head node' or a 'container node'
            - Static Lists, which turns a struct into a single list, with the 'head node'
              representing the list itself
            - Non-static Lists, which allows you to have multiple lists within a struct
            - Instantiated Lists, similar to non-static lists but comes with its own methods
              for creating and destroying a list (requires allocate() and deallocate() in the
              implementing struct)

        Note: In all these kind of lists, all nodes should be unique together with the head nodes.
              Lists can also be circular or linear.


    |-----------------|
    | STATIC LIST API |
    |-----------------|

        Interfaces:

          */optional interface static method onInsert takes thistype node returns nothing/*
          */optional interface static method onRemove takes thistype node returns nothing/*
                - onInsert() is called after a node is inserted everytime insert(), pushFront(),
                  or pushBack() is called
                - onRemove() is called before a node is removed everytime remove(), popFront(),
                  or popBack() is called
                - <node> is the node being inserted/removed

          */optional interface method onTraverse takes thistype node returns boolean/*
                - Runs in response to traverseForwards()/traverseBackwards() calls
                - <this> is the head node
                - <node> is the currently traversed node
                - Returning <true> removes <node> from the list <this>


        Fields:

          */readonly thistype prev/*
          */readonly thistype next/*
          */readonly static thistype front/*
          */readonly static thistype back/*
          */static constant thistype head/*
          */readonly static boolean empty/*
                - <front>, <back>, <head>, and <empty> are method operators


        Methods:

          */static method isLinked takes thistype node returns boolean/*
                - Checks if a node is currently belongs to a list

          */static method move takes thistype prev, thistype node returns nothing/*
                - Moves <node> next to <prev>
                - Only works if <node> is already linked
          */static method swap takes thistype nodeA, thistype nodeB returns nothing/*
                - Swaps the placement of two nodes

          */static method contains takes thistype node returns boolean/*
                - Checks if <head> contains the given node
          */static method getSize takes nothing returns integer/*
                - Gets the size of the list <head>
                - Time complexity: O(n)

          */static method traverseForwards takes nothing returns nothing/*
          */static method traverseBackwards takes nothing returns nothing/*
                - Traverses a list forwards/backwards and calls onTraverse() for
                  each node in the list

          */static method rotateLeft takes nothing returns nothing/*
          */static method rotateRight takes nothing returns nothing/*

          */static method insert takes thistype prev, thistype node returns nothing/*
          */static method remove takes thistype node returns nothing/*

          */static method pushFront takes thistype node returns nothing/*
                - Inlines to insert() if not on DEBUG_MODE
          */static method popFront takes nothing returns thistype/*

          */static method pushBack takes thistype node returns nothing/*
                - Inlines to insert() if not on DEBUG_MODE
          */static method popBack takes nothing returns thistype/*

          */static method clear takes nothing returns nothing/*
                - Does not call remove() for any node, but only unlinks them from the list
          */static method flush takes nothing returns nothing/*
                - Calls remove() for each node on the list starting from the front to the back node


    |---------------------|
    | NON-STATIC LIST API |
    |---------------------|

          */optional interface static method onInsert takes thistype node returns nothing/*
          */optional interface static method onRemove takes thistype node returns nothing/*
                - onInsert() is called after a node is inserted everytime insert(), pushFront(),
                  or pushBack() is called
                - onRemove() is called before a node is removed everytime remove(), popFront(),
                  or popBack() is called
                - <node> is the node being inserted/removed

          */optional interface method onConstruct takes nothing returns nothing/*
          */optional interface method onDestruct takes nothing returns nothing/*
                - This methods will be called when calling create()/destroy()
                - <this> refers to the list to be created/destroyed

          */interface static method allocate takes nothing returns thistype/*
                - The value returned by this method will be the value returned by create()
          */interface method deallocate takes nothing returns nothing/*
                - This method will be called when calling destroy()

          */optional interface method onTraverse takes thistype node returns boolean/*
                - Runs in response to traverseForwards()/traverseBackwards() calls
                - <this> is the head node
                - <node> is the currently traversed node
                - Returning <true> removes <node> from the list <this>


        Fields:

          */readonly thistype prev/*
          */readonly thistype next/*
          */readonly thistype front/*
          */readonly thistype back/*
          */readonly boolean empty/*
                - <front>, <back>, and <empty> are method operators


        Methods:

          */static method isLinked takes thistype node returns boolean/*
                - Checks if a node is currently belongs to a list

          */static method move takes thistype prev, thistype node returns nothing/*
                - Moves <node> next to <prev>
                - Only works if <node> is already linked
          */static method swap takes thistype nodeA, thistype nodeB returns nothing/*
                - Swaps the placement of two nodes

          */method contains takes thistype node returns boolean/*
                - Checks if <head> contains the given node
          */method getSize takes nothing returns integer/*
                - Gets the size of the list <head>
                - Time complexity: O(n)

          */method traverseForwards takes nothing returns nothing/*
          */method traverseBackwards takes nothing returns nothing/*
                - traverses a list forwards/backwards and calls onTraverse() for
                  each node in the list

          */method rotateLeft takes nothing returns nothing/*
          */method rotateRight takes nothing returns nothing/*

          */static method makeHead takes thistype node returns nothing/*
                - Turns a node into a list

          */static method insert takes thistype prev, thistype node returns nothing/*
          */static method remove takes thistype node returns nothing/*

          */method pushFront takes thistype node returns nothing/*
                - Inlines to insert() if not on DEBUG_MODE
          */method popFront takes nothing returns thistype/*

          */method pushBack takes thistype node returns nothing/*
                - Inlines to insert() if not on DEBUG_MODE
          */method popBack takes nothing returns thistype/*

          */method clear takes nothing returns nothing/*
                - Does not call remove() for any node, but only unlinks them from the list
          */method flush takes nothing returns nothing/*
                - Calls remove() for each node on the list starting from the front to the back node

          */static method create takes nothing returns thistype/*
                - Creates a new list
          */method destroy takes nothing returns nothing/*
                - Destroys the list (Also calls flush internally for InstantiatedList and InstantiatedListEx)


*///! endnovjass

library LinkedList /* v1.3.0 https://www.hiveworkshop.com/threads/linkedlist-modules.325635/


    */uses /*

    */optional ErrorMessage /*  https://github.com/nestharus/JASS/blob/master/jass/Systems/ErrorMessage/main.j


    *///! novjass

    /*
        Author:
            - AGD
        Credits:
            - Nestharus, Dirac, Bribe
                > For their scripts and discussions which I used as reference

        Pros:
            - Feature-rich (Can be)
            - Modular
            - Safety-oriented (On DEBUG_MODE, but not 100% fool-proof ofcourse)
            - Flexible (Does not enforce a built-in allocator - allows user to choose between a custom Alloc
              or the default vjass allocator, or neither)
            - Extensible (Provides interfaces)

        Note:
            If you are using using Dirac's 'LinkedListModule' library, you need to replace its contents with
            the compatibility lib provided alongside this library for all to work seamlessly.

    */
    |-----|
    | API |
    |-----|
    /*
    Note: All the fields except from 'prev' and 'next' are actually operators, so you might want to
          avoid using them from the interface methods that would be declared above them.
    =====================================================================================================
    List Fields Modules (For those who want to write or inline the core linked-list operations themselves)

      */module LinkedListFields/*

          */readonly thistype prev/*
          */readonly thistype next/*


      */module StaticListFields extends LinkedListFields/*

          */readonly static constant thistype sentinel/*
          */readonly static thistype front/*
          */readonly static thistype back/*
          */readonly static boolean empty/*


      */module ListFields extends LinkedListFields/*

          */readonly thistype front/*
          */readonly thistype back/*
          */readonly boolean empty/*

    =====================================================================================================
    Lite List Modules (Should be enough for most cases)

      */module LinkedListLite extends LinkedListFields/*

          */optional interface static method onInsert takes thistype node returns nothing/*
          */optional interface static method onRemove takes thistype node returns nothing/*
          */optional interface method onTraverse takes thistype node returns boolean/*

          */static method insert takes thistype prev, thistype node returns nothing/*
          */static method remove takes thistype node returns nothing/*

          */method traverseForwards takes nothing returns nothing/*
          */method traverseBackwards takes nothing returns nothing/*
                - Only present if onTraverse() is also present


      */module StaticListLite extends StaticListFields, LinkedListLite/*

          */static method pushFront takes thistype node returns nothing/*
          */static method popFront takes nothing returns thistype/*

          */static method pushBack takes thistype node returns nothing/*
          */static method popBack takes nothing returns thistype/*


      */module ListLite extends ListFields, LinkedListLite/*

          */method pushFront takes thistype node returns nothing/*
          */method popFront takes nothing returns thistype/*

          */method pushBack takes thistype node returns nothing/*
          */method popBack takes nothing returns thistype/*


      */module InstantiatedListLite extends ListLite/*

          */interface static method allocate takes nothing returns thistype/*
          */interface method deallocate takes nothing returns nothing/*
          */optional interface method onConstruct takes nothing returns nothing/*
          */optional interface method onDestruct takes nothing returns nothing/*

          */static method create takes nothing returns thistype/*
          */method destroy takes nothing returns nothing/*

    =====================================================================================================
    Standard List Modules

      */module LinkedList extends LinkedListLite/*

          */static method isLinked takes thistype node returns boolean/*


      */module StaticList extends StaticListLite, LinkedList/*

          */static method clear takes nothing returns nothing/*
          */static method flush takes nothing returns nothing/*


      */module List extends ListLite, LinkedList/*

          */static method makeHead takes thistype node returns nothing/*
          */method clear takes nothing returns nothing/*
          */method flush takes nothing returns nothing/*


      */module InstantiatedList extends InstantiatedListLite, List/*
 
    =====================================================================================================
    Feature-rich List Modules (For those who somehow need exotic linked-list operations)

      */module LinkedListEx extends LinkedList/*

          */static method move takes thistype prev, thistype node returns nothing/*
          */static method swap takes thistype nodeA, thistype nodeB returns nothing/*


      */module StaticListEx extends StaticList, LinkedListEx/*

          */static method contains takes thistype node returns boolean/*
          */static method getSize takes nothing returns integer/*
          */static method rotateLeft takes nothing returns nothing/*
          */static method rotateRight takes nothing returns nothing/*


      */module ListEx extends List, LinkedListEx/*

          */method contains takes thistype node returns boolean/*
          */method getSize takes nothing returns integer/*
          */method rotateLeft takes nothing returns nothing/*
          */method rotateRight takes nothing returns nothing/*


      */module InstantiatedListEx extends InstantiatedList, ListEx/*


    *///! endnovjass

    /*========================================= CONFIGURATION ===========================================
    *   Only affects DEBUG_MODE
    *   If false, throws warnings instead (Errors pauses the game (Or stops the thread) while warnings do not)
    */
    globals
        private constant boolean THROW_ERRORS = true
    endglobals
    /*====================================== END OF CONFIGURATION =====================================*/

    static if DEBUG_MODE then
        public function AssertError takes boolean condition, string methodName, string structName, integer node, string message returns nothing
            static if LIBRARY_ErrorMessage then
                static if THROW_ERRORS then
                    call ThrowError(condition, SCOPE_PREFIX, methodName, structName, node, message)
                else
                    call ThrowWarning(condition, SCOPE_PREFIX, methodName, structName, node, message)
                endif
            else
                if condition then
                    static if THROW_ERRORS then
                        call BJDebugMsg("|cffff0000[ERROR]|r [Library: " + SCOPE_PREFIX + "] [Struct: " + structName + "] [Method: " + methodName + "] [Instance: " + I2S(node) + "] : |cffff0000" + message + "|r")
                        call PauseGame(true)
                    else
                        call BJDebugMsg("|cffffcc00[WARNING]|r [Library: " + SCOPE_PREFIX + "] [Struct: " + structName + "] [Method: " + methodName + "] [Instance: " + I2S(node) + "] : |cffffcc00" + message + "|r")
                    endif
                endif
            endif
        endfunction
    endif

    private module LinkedListUtils
        method p_clear takes nothing returns nothing
            set this.next.prev = 0
            set this.prev.next = 0
            set this.prev = this
            set this.next = this
        endmethod
        method p_flush takes nothing returns nothing
            local thistype node = this.prev
            loop
                exitwhen node == this
                call remove(node)
                set node = node.prev
            endloop
        endmethod
    endmodule
    private module LinkedListUtilsEx
        implement LinkedListUtils
        method p_contains takes thistype toFind returns boolean
            local thistype node = this.next
            loop
                exitwhen node == this
                if node == toFind then
                    return true
                endif
                set node = node.next
            endloop
            return false
        endmethod
        method p_getSize takes nothing returns integer
            local integer count = 0
            local thistype node = this.next
            loop
                exitwhen node == this
                set count = count + 1
                set node = node.next
            endloop
            return count
        endmethod
    endmodule

    private module LinkedListLiteBase
        implement LinkedListFields
        debug method p_isEmptyHead takes nothing returns boolean
            debug return this == this.next and this == this.prev
        debug endmethod
        static method p_insert takes thistype this, thistype node returns nothing
            local thistype next = this.next
            set node.prev = this
            set node.next = next
            set next.prev = node
            set this.next = node
        endmethod
        static method p_remove takes thistype node returns nothing
            set node.next.prev = node.prev
            set node.prev.next = node.next
        endmethod
        static method insert takes thistype this, thistype node returns nothing
            debug call AssertError(node == 0, "insert()", "thistype", 0, "Cannot insert null node")
            debug call AssertError(not node.p_isEmptyHead() and (node.next.prev == node or node.prev.next == node), "insert()", "thistype", 0, "Already linked node [" + I2S(node) + "]: prev = " + I2S(node.prev) + " ; next = " + I2S(node.next))
            call p_insert(this, node)
            static if thistype.onInsert.exists then
                call onInsert(node)
            endif
        endmethod
        static method remove takes thistype node returns nothing
            debug call AssertError(node == 0, "remove()", "thistype", 0, "Cannot remove null node")
            debug call AssertError(node.next.prev != node and node.prev.next != node, "remove()", "thistype", 0, "Invalid node [" + I2S(node) + "]")
            static if thistype.onRemove.exists then
                call onRemove(node)
            endif
            call p_remove(node)
        endmethod
        static if thistype.onTraverse.exists then
            method p_traverse takes boolean forward returns nothing
                local thistype node
                local thistype next
                debug local thistype prev
                debug local boolean array traversed
                if forward then
                    set node = this.next
                    loop
                        exitwhen node == this or node.prev.next != node
                        debug call AssertError(traversed[node], "traverseForwards()", "thistype", this, "A node was traversed twice in a single traversal")
                        debug set traversed[node] = true
                        debug set prev = node.prev
                        set next = node.next
                        if this.onTraverse(node) then
                            call remove(node)
                            debug set traversed[node] = false
                        debug elseif next.prev == prev then
                            debug set traversed[node] = false
                        endif
                        set node = next
                    endloop
                else
                    set node = this.prev
                    loop
                        exitwhen node == this or node.next.prev != node
                        debug call AssertError(traversed[node], "traverseBackwards()", "thistype", this, "A node was traversed twice in a single traversal")
                        debug set traversed[node] = true
                        debug set prev = node.next
                        set next = node.prev
                        if this.onTraverse(node) then
                            call remove(node)
                            debug set traversed[node] = false
                        debug elseif next.prev == prev then
                            debug set traversed[node] = false
                        endif
                        set node = next
                    endloop
                endif
            endmethod
            method traverseForwards takes nothing returns nothing
                call this.p_traverse(true)
            endmethod
            method traverseBackwards takes nothing returns nothing
                call this.p_traverse(false)
            endmethod
        endif
    endmodule
    private module LinkedListBase
        implement LinkedListLiteBase
        static method isLinked takes thistype node returns boolean
            return node.next.prev == node or node.prev.next == node
        endmethod
    endmodule

    module LinkedListFields
        readonly thistype prev
        readonly thistype next
    endmodule
    module LinkedListLite
        implement LinkedListLiteBase
        implement optional LinkedListLiteModuleCompatibility // For API compatibility with Dirac's 'LinkedListModule' library
    endmodule
    module LinkedList
        implement LinkedListBase
        implement optional LinkedListModuleCompatibility // For API compatibility with Dirac's 'LinkedListModule' library
    endmodule
    module LinkedListEx
        implement LinkedListBase
        static method p_move takes thistype prev, thistype node returns nothing
            call p_remove(node)
            call p_insert(prev, node)
        endmethod
        static method move takes thistype prev, thistype node returns nothing
            debug call AssertError(not isLinked(node), "move()", "thistype", 0, "Cannot use unlinked node [" + I2S(node) + "]")
            call p_move(prev, node)
        endmethod
        static method swap takes thistype this, thistype node returns nothing
            local thistype thisPrev = this.prev
            local thistype thisNext = this.next
            debug call AssertError(this == 0, "swap()", "thistype", 0, "Cannot swap null node")
            debug call AssertError(node == 0, "swap()", "thistype", 0, "Cannot swap null node")
            debug call AssertError(not isLinked(this), "swap()", "thistype", 0, "Cannot use unlinked node [" + I2S(this) + "]")
            debug call AssertError(not isLinked(node), "swap()", "thistype", 0, "Cannot use unlinked node [" + I2S(node) + "]")
            call p_move(node, this)
            if thisNext != node then
                call p_move(thisPrev, node)
            endif
        endmethod
    endmodule

    module StaticListFields
        implement LinkedListFields
        static constant method operator head takes nothing returns thistype
            return 0
        endmethod
        static method operator back takes nothing returns thistype
            return head.prev
        endmethod
        static method operator front takes nothing returns thistype
            return head.next
        endmethod
        static method operator empty takes nothing returns boolean
            return front == head
        endmethod
    endmodule
    module StaticListLite
        implement StaticListFields
        implement LinkedListLiteBase
        static method pushFront takes thistype node returns nothing
            debug call AssertError(node == 0, "pushFront()", "thistype", 0, "Cannot use null node")
            debug call AssertError(not node.p_isEmptyHead() and (node.next.prev == node or node.prev.next == node), "pushFront()", "thistype", 0, "Already linked node [" + I2S(node) + "]: prev = " + I2S(node.prev) + " ; next = " + I2S(node.next))
            call insert(head, node)
        endmethod
        static method popFront takes nothing returns thistype
            local thistype node = front
            debug call AssertError(node.prev != head, "popFront()", "thistype", 0, "Invalid list")
            call remove(node)
            return node
        endmethod
        static method pushBack takes thistype node returns nothing
            debug call AssertError(node == 0, "pushBack()", "thistype", 0, "Cannot use null node")
            debug call AssertError(not node.p_isEmptyHead() and (node.next.prev == node or node.prev.next == node), "pushBack()", "thistype", 0, "Already linked node [" + I2S(node) + "]: prev = " + I2S(node.prev) + " ; next = " + I2S(node.next))
            call insert(back, node)
        endmethod
        static method popBack takes nothing returns thistype
            local thistype node = back
            debug call AssertError(node.next != head, "popBack()", "thistype", 0, "Invalid list")
            call remove(node)
            return node
        endmethod
    endmodule
    module StaticList
        implement StaticListLite
        implement LinkedListBase
        implement LinkedListUtils
        static method clear takes nothing returns nothing
            call head.p_clear()
        endmethod
        static method flush takes nothing returns nothing
            call head.p_flush()
        endmethod
    endmodule
    module StaticListEx
        implement StaticList
        implement LinkedListEx
        implement LinkedListUtilsEx
        static method contains takes thistype node returns boolean
            return head.p_contains(node)
        endmethod
        static method getSize takes nothing returns integer
            return head.p_getSize()
        endmethod
        static method rotateLeft takes nothing returns nothing
            call p_move(back, front)
        endmethod
        static method rotateRight takes nothing returns nothing
            call p_move(head, back)
        endmethod
    endmodule

    module ListFields
        implement LinkedListFields
        method operator back takes nothing returns thistype
            return this.prev
        endmethod
        method operator front takes nothing returns thistype
            return this.next
        endmethod
        method operator empty takes nothing returns boolean
            return this.next == this
        endmethod
    endmodule
    module ListLite
        implement ListFields
        implement LinkedListLiteBase
        method pushFront takes thistype node returns nothing
            debug call AssertError(this == 0, "pushFront()", "thistype", 0, "Null list")
            debug call AssertError(this.next.prev != this, "pushFront()", "thistype", this, "Invalid list")
            debug call AssertError(node == 0, "pushFront()", "thistype", this, "Cannot insert null node")
            debug call AssertError(not node.p_isEmptyHead() and (node.next.prev == node or node.prev.next == node), "pushFront()", "thistype", this, "Already linked node [" + I2S(node) + "]: prev = " + I2S(node.prev) + " ; next = " + I2S(node.next))
            call insert(this, node)
        endmethod
        method popFront takes nothing returns thistype
            local thistype node = this.next
            debug call AssertError(this == 0, "popFront()", "thistype", 0, "Null list")
            debug call AssertError(node.prev != this, "popFront()", "thistype", this, "Invalid list")
            call remove(node)
            return node
        endmethod
        method pushBack takes thistype node returns nothing
            debug call AssertError(this == 0, "pushBack()", "thistype", 0, "Null list")
            debug call AssertError(this.next.prev != this, "pushBack()", "thistype", this, "Invalid list")
            debug call AssertError(node == 0, "pushBack()", "thistype", this, "Cannot insert null node")
            debug call AssertError(not node.p_isEmptyHead() and (node.next.prev == node or node.prev.next == node), "pushBack()", "thistype", this, "Already linked node [" + I2S(node) + "]: prev = " + I2S(node.prev) + " ; next = " + I2S(node.next))
            call insert(this.prev, node)
        endmethod
        method popBack takes nothing returns thistype
            local thistype node = this.prev
            debug call AssertError(this == 0, "popBack()", "thistype", 0, "Null list")
            debug call AssertError(node.next != this, "pushFront()", "thistype", this, "Invalid list")
            call remove(node)
            return node
        endmethod
    endmodule
    module List
        implement ListLite
        implement LinkedListBase
        implement LinkedListUtils
        static method makeHead takes thistype node returns nothing
            set node.prev = node
            set node.next = node
        endmethod
        method clear takes nothing returns nothing
            debug call AssertError(this == 0, "clear()", "thistype", 0, "Null list")
            debug call AssertError(this.next.prev != this, "clear()", "thistype", this, "Invalid list")
            call this.p_clear()
        endmethod
        method flush takes nothing returns nothing
            debug call AssertError(this == 0, "flush()", "thistype", 0, "Null list")
            debug call AssertError(this.next.prev != this, "flush()", "thistype", this, "Invalid list")
            call this.p_flush()
        endmethod
    endmodule
    module ListEx
        implement List
        implement LinkedListEx
        implement LinkedListUtilsEx
        method contains takes thistype node returns boolean
            debug call AssertError(this == 0, "contains()", "thistype", 0, "Null list")
            debug call AssertError(this.next.prev != this, "contains()", "thistype", this, "Invalid list")
            return this.p_contains(node)
        endmethod
        method getSize takes nothing returns integer
            debug call AssertError(this == 0, "getSize()", "thistype", 0, "Null list")
            debug call AssertError(this.next.prev != this, "getSize()", "thistype", this, "Invalid list")
            return this.p_getSize()
        endmethod
        method rotateLeft takes nothing returns nothing
            debug call AssertError(this == 0, "rotateLeft()", "thistype", 0, "Null list")
            debug call AssertError(this.next.prev != this, "rotateLeft()", "thistype", this, "Invalid list")
            call p_move(this.back, this.front)
        endmethod
        method rotateRight takes nothing returns nothing
            debug call AssertError(this == 0, "rotateRight()", "thistype", 0, "Null list")
            debug call AssertError(this.next.prev == this, "rotateRight()", "thistype", this, "Invalid list")
            call p_move(this, this.back)
        endmethod
    endmodule

    module InstantiatedListLite
        implement ListLite
        debug private boolean valid
        static method create takes nothing returns thistype
            local thistype node = allocate()
            set node.prev = node
            set node.next = node
            debug set node.valid = true
            static if thistype.onConstruct.exists then
                call node.onConstruct()
            endif
            return node
        endmethod
        method destroy takes nothing returns nothing
            debug call AssertError(this == 0, "destroy()", "thistype", 0, "Null list")
            debug call AssertError(this.next.prev != this, "destroy()", "thistype", this, "Invalid list")
            debug call AssertError(not this.valid, "destroy()", "thistype", this, "Double-free")
            debug set this.valid = false
            static if thistype.flush.exists then
                call this.flush()
            endif
            static if thistype.onDestruct.exists then
                call this.onDestruct()
            endif
            debug set this.prev = 0
            debug set this.next = 0
            call this.deallocate()
        endmethod
    endmodule
    module InstantiatedList
        implement List
        implement InstantiatedListLite
    endmodule
    module InstantiatedListEx
        implement ListEx
        implement InstantiatedList
    endmodule


endlibrary
