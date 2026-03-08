package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.utils.BitUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10967 extends BaseMapProcess
   {
      
      private var _state:Array = [];
      
      public function MapProcess_10967()
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
            var _loc2_:MovieClip = null;
            var _loc1_:int = 0;
            while(_loc1_ < 4)
            {
               _loc2_ = that.conLevel["item_" + _loc1_] as MovieClip;
               _loc2_.visible = !Boolean(_state[_loc1_]);
               _loc2_.buttonMode = !Boolean(_state[_loc1_]);
               _loc2_.addEventListener(MouseEvent.CLICK,clickItem);
               _loc1_++;
            }
         });
      }
      
      private function clickItem(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         _loc2_.removeEventListener(MouseEvent.CLICK,this.clickItem);
         getDefinitionByName("com.robot.app2.control.ShipModifyController").clickCrater(param1,7,this.updateData);
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
               _state.push(_loc2_[_loc3_ + 8]);
               _loc4_ += _loc2_[_loc3_ + 8];
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
      
      override public function destroy() : void
      {
      }
   }
}

