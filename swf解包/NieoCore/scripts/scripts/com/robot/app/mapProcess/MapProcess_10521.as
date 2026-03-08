package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10521 extends BaseMapProcess
   {
      
      private var clazz:*;
      
      public function MapProcess_10521()
      {
         super();
      }
      
      override protected function init() : void
      {
         if(this.clazz == null)
         {
            this.clazz = getDefinitionByName("com.robot.app2.control.ImmortalFightingSpiritController") as Class;
         }
         this.clazz.initForMap3001(this);
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.clazz.destroy();
      }
   }
}

