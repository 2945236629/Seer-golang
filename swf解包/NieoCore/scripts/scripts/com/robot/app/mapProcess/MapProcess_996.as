package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_996 extends BaseMapProcess
   {
      
      private var clazz:*;
      
      public function MapProcess_996()
      {
         super();
      }
      
      override protected function init() : void
      {
         if(this.clazz == null)
         {
            this.clazz = getDefinitionByName("com.robot.app2.control.MoLingKingRevengeController") as Class;
         }
         this.clazz.initForMap1999(this);
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.clazz.destroy();
      }
   }
}

