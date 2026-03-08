package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.DisplayObject;
   
   public class MapProcess_11909 extends BaseMapProcess
   {
      
      public function MapProcess_11909()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
      }
      
      public function showNpc(param1:Array) : void
      {
         var _loc4_:DisplayObject = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc2_:int = int(conLevel.numChildren);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = conLevel.getChildAt(_loc3_);
            _loc5_ = _loc4_.name;
            _loc6_ = _loc5_.split("_")[1];
            _loc4_.visible = param1.indexOf(_loc6_) != -1;
            _loc3_++;
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}

