package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   
   public class MapProcess_457 extends BaseMapProcess
   {
      
      public var _taskMC:MovieClip;
      
      public function MapProcess_457()
      {
         super();
      }
      
      private function getStoryMCHanlder(param1:MovieClip) : void
      {
         this._taskMC = param1;
      }
      
      override protected function init() : void
      {
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}

