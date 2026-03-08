package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_967 extends BaseMapProcess
   {
      
      public function MapProcess_967()
      {
         super();
         getDefinitionByName("com.robot.app2.control.InterstellarMusicianController").setup(this);
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = topLevel.mouseEnabled = false;
         getDefinitionByName("com.robot.app2.mapProcess.control.activityControl.StrongKnightBattleController").initForMap(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.control.InterstellarMusicianController").destroy();
         getDefinitionByName("com.robot.app2.mapProcess.control.activityControl.StrongKnightBattleController").destroy();
      }
   }
}

