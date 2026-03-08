package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task1050;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.debug.DebugTrace;
   
   public class MapProcess_728 extends BaseMapProcess
   {
      
      public function MapProcess_728()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.initLeafActive();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         Task1050.initTaskForMap728(this);
      }
      
      private function initLeafActive() : void
      {
         conLevel["Task1050TanHaoMC"].visible = false;
         conLevel["leaf"].addEventListener(MouseEvent.ROLL_OVER,this.leafHandler2);
         conLevel["leaf"].addEventListener(MouseEvent.ROLL_OUT,this.leafHandler1);
      }
      
      private function leafHandler1(param1:MouseEvent) : void
      {
         this.leafMC.gotoAndStop(1);
         DebugTrace.show(this.leafMC.currentFrame);
      }
      
      private function leafHandler2(param1:MouseEvent) : void
      {
         this.leafMC.gotoAndStop(2);
         DebugTrace.show(this.leafMC.currentFrame);
      }
      
      private function get leafMC() : MovieClip
      {
         if(MapManager.currentMap.id == 728)
         {
            return conLevel["Task1050LeafMC"];
         }
         return null;
      }
      
      private function get taskMushBgMC() : MovieClip
      {
         if(MapManager.currentMap.id == 728)
         {
            return conLevel["Task1050MushBgMC"];
         }
         return null;
      }
      
      override public function destroy() : void
      {
         this.leafMC.removeEventListener(MouseEvent.ROLL_OVER,this.leafHandler2);
         this.leafMC.removeEventListener(MouseEvent.ROLL_OUT,this.leafHandler1);
         Task1050.destroy();
         super.destroy();
      }
   }
}

