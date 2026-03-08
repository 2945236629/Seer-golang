package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.*;
   import com.robot.app.toolBar.*;
   import com.robot.core.animate.*;
   import com.robot.core.config.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.*;
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.geom.*;
   import flash.ui.*;
   import flash.utils.*;
   
   public class MapProcess_443 extends BaseMapProcess
   {
      
      private var heart:MovieClip;
      
      private var mouseDownPoint:Point;
      
      private var knife:MovieClip;
      
      private var tempPoint:Point;
      
      private var ti:Timer;
      
      private var gaiyaTanglang_Mov:MovieClip;
      
      private var isCut:Boolean = false;
      
      public function MapProcess_443()
      {
         super();
      }
      
      override protected function init() : void
      {
         if(TasksManager.getTaskStatus(609) == TasksManager.ALR_ACCEPT)
         {
            this.heart = conLevel["heart"];
            this.knife = conLevel["knife"];
            this.heart.visible = false;
            this.knife.visible = false;
            Task609.initTask_443(this);
            return;
         }
         this.addTask573();
      }
      
      private function addTask573() : void
      {
         MainManager.actorModel.visible = true;
         this.heart = conLevel["heart"];
         this.knife = conLevel["knife"];
         this.gaiyaTanglang_Mov = animatorLevel["mov"];
         this.gaiyaTanglang_Mov.mouseEnabled = false;
         this.gaiyaTanglang_Mov.mouseChildren = false;
         if(!Task573.isComlpete && Boolean(Task573.isAccept))
         {
            topLevel.mouseEnabled = false;
            topLevel.mouseChildren = false;
            this.knife.mouseEnabled = false;
            this.knife.visible = false;
            this.isCut = false;
            this.ti = new Timer(600);
            this.ti.addEventListener(TimerEvent.TIMER,this.onT);
            ToolBarController.showOrHideAllUser(false);
            NpcDialog.show(NPC.SEER,["……什么……黑色的蛹……这难道是咤克斯正在进化吗？决不能让它得逞！"],["（快用鼠标点击蛹，来回摩擦。）"],[this.startTask573]);
         }
         else
         {
            this.heart.visible = false;
            this.knife.visible = false;
         }
      }
      
      private function startTask573() : void
      {
         this.heart.buttonMode = true;
         this.heart.addEventListener(MouseEvent.MOUSE_OVER,this.onMosue);
         this.heart.addEventListener(MouseEvent.MOUSE_OUT,this.onMosue);
         this.heart.addEventListener(MouseEvent.MOUSE_DOWN,this.onMosue);
         this.heart.addEventListener(MouseEvent.MOUSE_UP,this.onMosue);
      }
      
      private function removeE() : void
      {
         MainManager.getStage().removeEventListener(Event.ENTER_FRAME,this.onE);
         Mouse.show();
         this.heart.buttonMode = false;
         this.heart.removeEventListener(MouseEvent.MOUSE_OVER,this.onMosue);
         this.heart.removeEventListener(MouseEvent.MOUSE_OUT,this.onMosue);
         this.heart.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMosue);
         this.heart.removeEventListener(MouseEvent.MOUSE_UP,this.onMosue);
         this.ti.removeEventListener(TimerEvent.TIMER,this.onT);
         this.ti.stop();
      }
      
      private function onMosue(param1:MouseEvent) : void
      {
         switch(param1.type)
         {
            case MouseEvent.MOUSE_OVER:
               Mouse.hide();
               this.knife.stage.addEventListener(Event.ENTER_FRAME,this.onE);
               this.knife.visible = true;
               break;
            case MouseEvent.MOUSE_OUT:
               Mouse.show();
               this.knife.stage.removeEventListener(Event.ENTER_FRAME,this.onE);
               this.knife.visible = false;
               break;
            case MouseEvent.MOUSE_DOWN:
               this.ti.reset();
               this.mouseDownPoint = new Point(this.knife.parent.mouseX,this.knife.parent.mouseY);
               this.ti.start();
               break;
            case MouseEvent.MOUSE_UP:
               this.ti.reset();
               if(!this.isCut)
               {
                  this.onT(null);
               }
               this.mouseDownPoint = null;
         }
      }
      
      private function onT(param1:TimerEvent) : void
      {
         var _loc2_:Point = new Point(this.knife.parent.mouseX,this.knife.parent.mouseY);
         if(Boolean(this.mouseDownPoint))
         {
            if(this.mouseDownPoint != _loc2_)
            {
               this.cut();
            }
         }
      }
      
      private function onE(param1:Event) : void
      {
         var _loc2_:Point = null;
         _loc2_ = new Point(this.knife.stage.mouseX,this.knife.stage.mouseY);
         _loc2_ = this.knife.parent.globalToLocal(_loc2_);
         this.knife.x = _loc2_.x;
         this.knife.y = _loc2_.y;
      }
      
      private function cut() : void
      {
         this.isCut = true;
         this.heart.gotoAndStop(2);
         this.knife.visible = false;
         this.removeE();
         AnimateManager.playFullScreenAnimate(ClientConfig.getFullMovie("task573_3"),this.movEndFun0);
      }
      
      private function movEndFun0() : void
      {
         MainManager.actorModel.visible = false;
         this.gaiyaTanglang_Mov.gotoAndStop(2);
         AnimateManager.playMcAnimate(this.gaiyaTanglang_Mov,2,"mov",this.movEndFun);
      }
      
      private function movEndFun() : void
      {
         NpcDialog.show(NPC.LEIYI,["替我守护好星球，我一定会回来的！"],null,null,false,this.dialog1);
      }
      
      private function dialog1() : void
      {
         NpcDialog.show(NPC.GAIYA,["少罗嗦！我会帮你顶上的，快去找卡兔吧，一定要拿回神兵利器！"],null,null,false,this.dialog2);
      }
      
      private function dialog2() : void
      {
         MapManager.changeMap(437);
      }
      
      private function removeTask573() : void
      {
         if(Boolean(this.gaiyaTanglang_Mov))
         {
            this.gaiyaTanglang_Mov.gotoAndStop(1);
         }
         ToolBarController.showOrHideAllUser(true);
         if(Boolean(this.ti))
         {
            this.ti.reset();
            this.ti.removeEventListener(TimerEvent.TIMER,this.onT);
            this.ti = null;
         }
         Mouse.show();
      }
      
      override public function destroy() : void
      {
         Task609.destroy();
         MainManager.actorModel.visible = true;
         this.removeTask573();
      }
   }
}

