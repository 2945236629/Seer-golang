package com.robot.app.mapProcess
{
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10336 extends BaseMapProcess
   {
      
      public function MapProcess_10336()
      {
         super();
      }
      
      override protected function init() : void
      {
         LevelManager.iconLevel.visible = false;
         conLevel["hit1"].mouseEnabled = false;
         conLevel["hit1"].mouseChildren = false;
         conLevel["hit2"].mouseEnabled = false;
         conLevel["hit2"].mouseChildren = false;
         conLevel["hit3"].mouseEnabled = false;
         conLevel["hit3"].mouseChildren = false;
         getDefinitionByName("com.robot.app2.control.TwelveDoorController").initFor10336(this);
         getDefinitionByName("com.robot.app2.control.TwelveDoorSelectLevelController").initFor10336(this);
      }
      
      override public function destroy() : void
      {
         LevelManager.iconLevel.visible = true;
         getDefinitionByName("com.robot.app2.control.TwelveDoorController").destroyFor10336();
         getDefinitionByName("com.robot.app2.control.TwelveDoorSelectLevelController").destroyFor10336();
         super.destroy();
      }
   }
}

