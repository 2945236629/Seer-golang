package com.robot.app.mapProcess
{
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   
   public class MapProcess_10282 extends BaseMapProcess
   {
      
      public function MapProcess_10282()
      {
         super();
      }
      
      override protected function init() : void
      {
         (MapManager.currentMap.root["effect"] as MovieClip).mouseChildren = false;
         (MapManager.currentMap.root["effect"] as MovieClip).mouseEnabled = false;
      }
   }
}

