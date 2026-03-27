//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//~~ Alloc ~~ By Sevion ~~ Version 1.09 ~~
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//
//  What is Alloc?
//         - Alloc implements an intuitive allocation method for array structs
//
//    =Pros=
//         - Efficient.
//         - Simple.
//         - Less overhead than regular structs.
//
//    =Cons=
//         - Must use array structs (hardly a con).
//         - Must manually call OnDestroy.
//         - Must use Delegates for inheritance.
//         - No default values for variables (use onInit instead).
//         - No array members (use another Alloc struct as a linked list or type declaration).
//
//    Methods:
//         - struct.allocate()
//         - struct.deallocate()
//
//           These methods are used just as they should be used in regular structs.
//
//    Modules:
//         - Alloc
//           Implements the most basic form of Alloc. Includes only create and destroy
//           methods.
//
//  Details:
//         - Less overhead than regular structs
//
//         - Use array structs when using Alloc. Put the implement at the top of the struct.
//
//         - Alloc operates almost exactly the same as default structs in debug mode with the exception of onDestroy.
//
//  How to import:
//         - Create a trigger named Alloc.
//         - Convert it to custom text and replace the whole trigger text with this.
//
//  Thanks:
//         - Nestharus for the method of allocation and suggestions on further merging.
//         - Bribe for suggestions like the static if and method names.
//         - PurgeandFire111 for some suggestions like the merging of Alloc and AllocX as well as OnDestroy stuff.
//
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
library Alloc    
    module Alloc
        private static integer instanceCount = 0
        private thistype recycle
   
        static method allocate takes nothing returns thistype
            local thistype this
   
            if (thistype(0).recycle == 0) then
                debug if (instanceCount == JASS_MAX_ARRAY_SIZE) then
                    debug call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "Alloc ERROR: Attempted to allocate too many instances!")
                    debug return 0
                debug endif
                set instanceCount = instanceCount + 1
                set this = instanceCount
            else
                set this = thistype(0).recycle
                set thistype(0).recycle = thistype(0).recycle.recycle
            endif

            debug set this.recycle = -1
   
            return this
        endmethod
   
        method deallocate takes nothing returns nothing
            debug if (this.recycle != -1) then
                debug call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "Alloc ERROR: Attempted to deallocate an invalid instance at [" + I2S(this) + "]!")
                debug return
            debug endif

            set this.recycle = thistype(0).recycle
            set thistype(0).recycle = this
        endmethod
    endmodule
endlibrary
