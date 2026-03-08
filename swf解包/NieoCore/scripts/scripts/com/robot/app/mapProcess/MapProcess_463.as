package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.*;
   import com.robot.core.event.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.geom.*;
   
   public class MapProcess_463 extends BaseMapProcess
   {
      
      private static var door_hitMc:MovieClip;
      
      private static var door_mc:MovieClip;
      
      private static var hit_0:MovieClip;
      
      public static var isOpen:Boolean = false;
      
      public function MapProcess_463()
      {
         super();
      }
      
      private static function onClickDoor(param1:MouseEvent) : void
      {
         MainManager.actorModel.walkAction(new Point(762,361));
      }
      
      public static function openDoorHandler() : void
      {
         door_hitMc.visible = true;
         hit_0.visible = true;
         door_hitMc.mouseEnabled = true;
         hit_0.mouseEnabled = true;
         door_mc.gotoAndStop(2);
         door_hitMc.addEventListener(MouseEvent.CLICK,onClickDoor);
      }
      
      override protected function init() : void
      {
         door_hitMc = this.conLevel["door_0"];
         door_mc = this.conLevel["door_mc"];
         hit_0 = this.conLevel["hit_0"];
         door_hitMc.mouseEnabled = false;
         hit_0.mouseEnabled = false;
         MainManager.actorModel.addEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkHAndler);
         Task568.initTask_463(this);
      }
      
      public function onWalkHAndler(param1:RobotEvent) : void
      {
         var _loc2_:Point = MainManager.actorModel.localToGlobal(new Point());
         if(hit_0.hitTestPoint(_loc2_.x,_loc2_.y))
         {
            if(isOpen)
            {
               door_hitMc.removeEventListener(MouseEvent.CLICK,onClickDoor);
               MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkHAndler);
               MainManager.actorModel.stop();
               MapManager.changeMap(464);
            }
         }
      }
      
      override public function destroy() : void
      {
         Task568.destory();
      }
   }
}

