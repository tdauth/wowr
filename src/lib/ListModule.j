library ListModule
// grim001: ListModule
//===========================================================================
// Information:
//==============
//
//     This library provides the List module, which allows you to easily create
// a linked list of all of the allocated instances of a struct-type. Iterating
// through a linked list is about 12% faster than iteratating through an array
// in JASS. There is no faster method to iterate through a list of structs than
// the method used by this module. Aside from the marginal speed gain, the best
// use of this library is to hide some ugly low-level code from your structs.
// Rather than manually building and maintaining a list of struct instances,
// just implement the List module, and your code will become much prettier.
//
//===========================================================================
// How to use the List module:
//=============================
//
//     Using the List module is pretty simple. First, implement it in your
// struct (preferably at the top to avoid unnecessary TriggerEvaluate calls).
// In the struct's create method, you must call listAdd(). In the onDestroy
// method, you must also call listRemove(). An example is shown below:
/*
    struct Example
        implement List
        
        static method create takes nothing returns Example
            local Example this = allocate()
                call listAdd() //This method adds the instance to the list.
            return this
        endmethod
        
        method onDestroy takes nothing returns nothing
            call listRemove() //This method removes the instance from the list.
        endmethod
    endstruct
*/
//     The requirement to call listAdd() and listRemove() will be done away
// with once JassHelper supports module onDestroy and module onCreate, but
// for now, it is not too much of a burden.
//
//     Once this is done, your struct will gain all of the methods detailed
// in the API section. Below is an example of how to iterate through the list
// of allocated structs of the implementing struct-type:
/*
    function IterationExample takes nothing returns nothing
        local Example e = Example.first
            loop
                exitwhen e == 0
                //Do something with e here.
                set e = e.next
            endloop
        //Use .last and .prev instead to iterate backwards.
    endmethod
*/
//
//===========================================================================
// List module API:
//==================
//
// (readonly)(static) first -> thistype
//   This member contains the first instance of thistype in the list.
//
// (readonly)(static) last -> thistype
//   This member contains the last instance of thistype in the list.
//
// (readonly)(static) count -> integer
//   This member contains the number of allocated structs of thistype.
//
// (readonly) next -> thistype
//   This member contains the next instance of thistype in the list.
//
// (readonly) prev -> thistype
//   This member contains the previous instance of thistype in the list.
//
// listAdd()
//   This method adds this instance to the list of structs of thistype.
//   This should be called on each instance after it is allocated (within
//   the create method).
//
// listRemove()
//   This method removes this instance from the list of structs of thistype.
//   This should be called on each instance before it is destroyed (within
//   the onDestroy method).
//
// (static) listDestroy()
//   This method destroys all the structs of thistype within the list.
//
//===========================================================================

public module List
    private static boolean destroying = false
    private boolean inlist = false
    
    readonly static integer count = 0
    
    readonly thistype next = 0
    readonly thistype prev = 0
    
    static method operator first takes nothing returns thistype
        return thistype(0).next
    endmethod
    
    static method operator last takes nothing returns thistype
        return thistype(0).prev
    endmethod
    
    method listRemove takes nothing returns nothing
        if not inlist then
            return
        endif
        set inlist = false
        set prev.next = next
        set next.prev = prev
        set count = count - 1
    endmethod

    method listAdd takes nothing returns nothing
        if inlist or destroying then
            return
        endif
        set inlist = true
        set last.next = this
        set prev = last
        set thistype(0).prev = this
        set count = count + 1
    endmethod
    
    static method listDestroy takes nothing returns nothing
        local thistype this = last
            set destroying = true
            loop
                exitwhen this == 0
                call destroy()
                set this = prev
            endloop
            set destroying = false
    endmethod
    
endmodule

endlibrary
