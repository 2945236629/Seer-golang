package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10781 extends BaseMapProcess
   {
      
      public function MapProcess_10781()
      {
         super();
      }
      
      override protected function init() : void
      {
         getDefinitionByName("com.robot.app2.control.TiyasiSuperEvolveController").initForMap(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.control.TiyasiSuperEvolveController").destroy();
         super.destroy();
      }
   }
}

