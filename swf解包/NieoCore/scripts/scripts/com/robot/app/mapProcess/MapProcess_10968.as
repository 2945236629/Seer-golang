package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.utils.BitUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10968 extends BaseMapProcess
   {
      
      private var _state:Array = [];
      
      private var _npcIsClicked:Boolean = false;
      
      public function MapProcess_10968()
      {
         super();
      }
      
      override protected function init() : void
      {
         var that:* = undefined;
         getDefinitionByName("com.robot.app2.control.ShipModifyController").initForMap(this);
         that = this;
         this.updateData(function():void
         {
            KTool.getMultiValue([2553],function(param1:Array):void
            {
               var _loc2_:int = 0;
               var _loc3_:MovieClip = null;
               _loc2_ = 0;
               if(param1[0] != 12)
               {
                  (that.conLevel["npc"] as MovieClip).addEventListener(MouseEvent.CLICK,onClickNpc);
                  (that.conLevel["npc"] as MovieClip).buttonMode = true;
                  _loc2_ = 0;
                  while(_loc2_ < 4)
                  {
                     (that.conLevel["item_" + _loc2_]["arrow"] as MovieClip).visible = false;
                     _loc2_++;
                  }
               }
               else
               {
                  that.conLevel["npc"].visible = false;
                  _loc2_ = 0;
                  while(_loc2_ < 4)
                  {
                     _loc3_ = that.conLevel["item_" + _loc2_] as MovieClip;
                     _loc3_["arrow"].visible = true;
                     _loc3_.visible = !Boolean(_state[_loc2_]);
                     _loc3_.buttonMode = !Boolean(_state[_loc2_]);
                     _loc3_.addEventListener(MouseEvent.CLICK,clickItem);
                     _loc2_++;
                  }
               }
            });
         });
      }
      
      private function clickItem(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         _loc2_.removeEventListener(MouseEvent.CLICK,this.clickItem);
         getDefinitionByName("com.robot.app2.control.ShipModifyController").clickCrater(param1,5,this.updateData);
      }
      
      private function updateData(param1:Function = null) : void
      {
         var func:Function = param1;
         KTool.getMultiValue([2554],function(param1:Array):void
         {
            var _loc3_:int = 0;
            _state = [];
            var _loc2_:Array = BitUtils.bitToList(param1[0]);
            var _loc4_:int = 0;
            _loc3_ = 0;
            while(_loc3_ < 4)
            {
               _state.push(_loc2_[_loc3_]);
               _loc4_ += _loc2_[_loc3_];
               _loc3_++;
            }
            if(_loc4_ == 4)
            {
               getDefinitionByName("com.robot.app2.control.ShipModifyController").nextAction();
            }
            if(func != null)
            {
               func();
            }
         });
      }
      
      private function onClickNpc(param1:MouseEvent) : void
      {
         if(!this._npcIsClicked)
         {
            this._npcIsClicked = true;
            getDefinitionByName("com.robot.app2.control.ShipModifyController").nextAction();
         }
         else
         {
            ModuleManager.showAppModule("ShipTipsPanel");
         }
      }
      
      override public function destroy() : void
      {
         (this.conLevel["npc"] as MovieClip).removeEventListener(MouseEvent.CLICK,this.onClickNpc);
      }
   }
}

