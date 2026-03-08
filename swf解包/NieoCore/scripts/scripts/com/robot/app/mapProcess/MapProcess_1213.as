package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   
   public class MapProcess_1213 extends BaseMapProcess
   {
      
      public function MapProcess_1213()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.show();
      }
      
      private function show() : void
      {
         KTool.getMultiValue([4485],function(param1:Array):void
         {
            var _loc2_:int = 0;
            _loc2_ = 1;
            while(_loc2_ < 10)
            {
               if(_loc2_ == 3)
               {
                  (MapManager.currentMap.controlLevel["mc2_" + _loc2_] as MovieClip).mouseChildren = false;
                  (MapManager.currentMap.controlLevel["mc2_" + _loc2_] as MovieClip).mouseEnabled = false;
                  MapManager.currentMap.controlLevel["mc2_" + _loc2_].visible = KTool.getBit(param1[0],_loc2_) > 0;
               }
               else if(_loc2_ == 7 || _loc2_ == 8 || _loc2_ == 9)
               {
                  (MapManager.currentMap.controlLevel["mc0_" + _loc2_] as MovieClip).mouseChildren = false;
                  (MapManager.currentMap.controlLevel["mc0_" + _loc2_] as MovieClip).mouseEnabled = false;
                  MapManager.currentMap.controlLevel["mc0_" + _loc2_].visible = KTool.getBit(param1[0],_loc2_) > 0;
               }
               else if(_loc2_ == 6 || _loc2_ == 5)
               {
                  (MapManager.currentMap.controlLevel["mc1_" + _loc2_] as MovieClip).mouseChildren = false;
                  (MapManager.currentMap.controlLevel["mc1_" + _loc2_] as MovieClip).mouseEnabled = false;
                  MapManager.currentMap.controlLevel["mc1_" + _loc2_].visible = KTool.getBit(param1[0],_loc2_) > 0;
               }
               _loc2_++;
            }
         });
      }
   }
}

