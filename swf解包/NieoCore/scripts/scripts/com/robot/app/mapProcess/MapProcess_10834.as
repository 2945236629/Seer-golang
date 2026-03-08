package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10834 extends BaseMapProcess
   {
      
      private var cls:*;
      
      public function MapProcess_10834()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.cls = getDefinitionByName("com.robot.app2.mapProcess.control.VanguardStagingController");
         this.cls.initForMap10834(this);
      }
      
      public function onGoto1(param1:MovieClip) : void
      {
         var _loc2_:uint = uint(param1.name.split("_")[1]) - 1;
         this.cls.onHit(_loc2_);
      }
      
      override public function destroy() : void
      {
         this.cls.destory10834ForLeave();
         this.cls = null;
      }
   }
}

