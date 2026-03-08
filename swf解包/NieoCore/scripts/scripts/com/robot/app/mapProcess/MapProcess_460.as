package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.*;
   import com.robot.core.event.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.geom.*;
   import org.taomee.manager.*;
   
   public class MapProcess_460 extends BaseMapProcess
   {
      
      private var mmIn:MovieClip;
      
      private var mmOut:MovieClip;
      
      private var doorMc:MovieClip;
      
      private var isAtRight:Boolean;
      
      public function MapProcess_460()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.mmIn = this.conLevel["mm"];
         this.mmOut = this.conLevel["mm2"];
         this.doorMc = this.conLevel["doorMc"];
         ToolTipManager.add(this.doorMc,"入口");
         this.doorMc.buttonMode = true;
         this.mmIn.mouseChildren = false;
         this.mmIn.mouseEnabled = false;
         this.mmOut.mouseChildren = false;
         this.mmOut.mouseEnabled = false;
         this.doorMc.addEventListener(MouseEvent.CLICK,this.onClickMMin);
         MainManager.actorModel.addEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkHAndler);
         Task560.initTask_460(this);
      }
      
      private function onClickMMin(param1:MouseEvent) : void
      {
         MainManager.actorModel.walkAction(new Point(800,450));
      }
      
      private function onClickMMout(param1:MouseEvent) : void
      {
         MainManager.actorModel.walkAction(new Point(1010,350));
         Task560.OutDoor();
      }
      
      public function onWalkHAndler(param1:RobotEvent) : void
      {
         var _loc2_:Point = MainManager.actorModel.localToGlobal(new Point());
         if(this.mmIn.hitTestPoint(_loc2_.x,_loc2_.y))
         {
            this.doorMc.removeEventListener(MouseEvent.CLICK,this.onClickMMin);
            this.doorMc.addEventListener(MouseEvent.CLICK,this.onClickMMout);
            ToolTipManager.add(this.doorMc,"出口");
            this.isAtRight = true;
            MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkHAndler);
            MainManager.actorModel.stop();
            MainManager.actorModel.pos = new Point(MainManager.actorModel.pos.x + 350,MainManager.actorModel.pos.y - 50);
            MainManager.actorModel.addEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkHAndler1);
            if(Boolean(MainManager.actorModel.pet))
            {
               MainManager.actorModel.pet.pos = new Point(MainManager.actorModel.pet.pos.x + 350,MainManager.actorModel.pet.pos.y - 50);
            }
            Task560.EnterDoor();
         }
      }
      
      public function onWalkHAndler1(param1:RobotEvent) : void
      {
         var _loc2_:Point = MainManager.actorModel.localToGlobal(new Point());
         if(this.mmOut.hitTestPoint(_loc2_.x,_loc2_.y))
         {
            this.doorMc.removeEventListener(MouseEvent.CLICK,this.onClickMMout);
            this.doorMc.addEventListener(MouseEvent.CLICK,this.onClickMMin);
            ToolTipManager.add(this.doorMc,"进口");
            this.isAtRight = false;
            MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkHAndler1);
            MainManager.actorModel.stop();
            MainManager.actorModel.pos = new Point(MainManager.actorModel.pos.x - 400,MainManager.actorModel.pos.y + 50);
            MainManager.actorModel.addEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkHAndler);
            if(Boolean(MainManager.actorModel.pet))
            {
               MainManager.actorModel.pet.pos = new Point(MainManager.actorModel.pet.pos.x - 400,MainManager.actorModel.pet.pos.y + 50);
            }
         }
      }
      
      override public function destroy() : void
      {
         MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkHAndler1);
         MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkHAndler);
         this.doorMc.removeEventListener(MouseEvent.CLICK,this.onClickMMout);
         this.doorMc.removeEventListener(MouseEvent.CLICK,this.onClickMMin);
      }
   }
}

