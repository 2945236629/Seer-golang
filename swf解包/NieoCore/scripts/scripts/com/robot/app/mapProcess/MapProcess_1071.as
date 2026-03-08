package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_1071 extends BaseMapProcess
   {
      
      public function MapProcess_1071()
      {
         super();
      }
      
      override protected function init() : void
      {
         getDefinitionByName("com.robot.app2.control.WangGuangmingAbilitiesController").initMap(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.control.WangGuangmingAbilitiesController").destroy();
      }
   }
}

