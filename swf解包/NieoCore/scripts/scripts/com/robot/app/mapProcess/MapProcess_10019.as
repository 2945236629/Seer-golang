package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10019 extends BaseMapProcess
   {
      
      public function MapProcess_10019()
      {
         super();
      }
      
      override protected function init() : void
      {
         getDefinitionByName("com.robot.app2.control.newSeer.NewSeerGrassTrain").enterMap10019();
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.control.newSeer.NewSeerGrassTrain").leaveMap10019();
      }
   }
}

