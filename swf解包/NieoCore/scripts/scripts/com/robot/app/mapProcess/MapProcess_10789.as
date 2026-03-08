package com.robot.app.mapProcess
{
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10789 extends BaseMapProcess
   {
      
      public function MapProcess_10789()
      {
         super();
      }
      
      override protected function init() : void
      {
         StatManager.sendStat2014("星球活动","进入活动首场景","2015运营活动");
         getDefinitionByName("com.robot.app.control.WeilltepperController").initForMap(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app.control.WeilltepperController").destroy();
      }
   }
}

