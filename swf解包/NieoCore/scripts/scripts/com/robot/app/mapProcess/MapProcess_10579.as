package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10579 extends BaseMapProcess
   {
      
      public function MapProcess_10579()
      {
         super();
      }
      
      override protected function init() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.ArmorUnionInwokeHideSkillController").initMap(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.ArmorUnionInwokeHideSkillController").destroy();
         super.destroy();
      }
   }
}

