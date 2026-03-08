package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.spt.FightBossController;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.CommandID;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.mode.AppModel;
   import com.robot.core.net.SocketConnection;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import flash.utils.clearTimeout;
   import flash.utils.getDefinitionByName;
   import org.taomee.events.SocketEvent;
   import org.taomee.manager.ToolTipManager;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcess_1723 extends BaseMapProcess
   {
      
      private var recorder1:SimpleButton;
      
      private var recorder2:SimpleButton;
      
      private var bossMC:MovieClip;
      
      private var doorMC:MovieClip;
      
      private var door0:MovieClip;
      
      private var door1:MovieClip;
      
      private var timer:Timer;
      
      private var timerID:int;
      
      private var clickMC:SimpleButton;
      
      private var doorGame:AppModel;
      
      public function MapProcess_1723()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.recorder1 = this.conLevel["recorder1_mc"];
         this.recorder2 = this.conLevel["recorder2_mc"];
         this.bossMC = this.conLevel["boss_mc"];
         this.bossMC.buttonMode = true;
         this.bossMC.mouseChildren = false;
         this.bossMC.gotoAndStop(1);
         this.doorMC = this.conLevel["door_mc"];
         this.door0 = this.conLevel["door_0"];
         ToolTipManager.add(this.door0,"神秘空间");
         this.door0.buttonMode = true;
         this.door0.visible = false;
         this.door1 = this.conLevel["door_1"];
         ToolTipManager.add(this.door1,"神秘空间");
         this.door1.buttonMode = true;
         this.door1.visible = false;
         this.doorMC.buttonMode = true;
         this.addEvent();
         topLevel["fog"].visible = false;
         this.timer = new Timer(6000);
         this.timer.addEventListener(TimerEvent.TIMER,this.onTimer);
         this.timer.start();
         SocketConnection.addCmdListener(CommandID.SYSTEM_TIME,this.onSystemTime);
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            conLevel["shadow" + _loc1_].visible = false;
            conLevel["pet" + _loc1_].visible = true;
            conLevel["shadow" + _loc1_].buttonMode = true;
            conLevel["shadow" + _loc1_].addEventListener(MouseEvent.CLICK,this.onClickShadow);
            _loc1_++;
         }
         conLevel["pet4"].gotoAndStop(2);
         conLevel.addEventListener(MouseEvent.CLICK,this.onMouseClick);
         this.update();
      }
      
      public function update(param1:* = null) : void
      {
         var e:* = param1;
         KTool.getMultiValue([140033],function(param1:Array):void
         {
            if(param1[0] > 0)
            {
               conLevel["rupeeEggBtn"].visible = false;
            }
            else
            {
               conLevel["rupeeEggBtn"].visible = true;
            }
         });
      }
      
      public function onMouseClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         var index:int = int(e.target.name.split("_")[1]);
         switch(e.target.name)
         {
            case "propCompartmentBtn":
               AnimateManager.playMcAnimate(conLevel["propCompartmentMc"],2,"mc2",function():void
               {
                  conLevel["propCompartmentMc"].visible = false;
               },false,true);
               break;
            case "rupeeEggBtn":
               KTool.socketSendCallBack(45900,function():void
               {
                  update();
               },[12,1]);
         }
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            conLevel["shadow" + _loc2_].gotoAndStop(3);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            conLevel["shadow" + _loc2_].gotoAndStop(2);
            _loc2_++;
         }
      }
      
      private function onSystemTime(param1:SocketEvent = null) : void
      {
      }
      
      private function onClickShadow(param1:Event) : void
      {
         var e:Event = param1;
         MainManager.actorModel.moveAndAction(new Point(e.currentTarget.x + 50,e.currentTarget.y + 50),function():void
         {
            FightManager.fightWithBoss("迷之黑影",1);
         });
      }
      
      private function addEvent() : void
      {
         this.bossMC.addEventListener(MouseEvent.CLICK,this.onBossMCClickHandler);
         this.doorMC.addEventListener(MouseEvent.CLICK,this.onDoorMCClickHandler);
      }
      
      private function removeEvent() : void
      {
         this.bossMC.removeEventListener(MouseEvent.CLICK,this.onBossMCClickHandler);
         this.doorMC.removeEventListener(MouseEvent.CLICK,this.onDoorMCClickHandler);
         if(this.doorMC.hasEventListener(Event.ENTER_FRAME))
         {
            this.doorMC.removeEventListener(Event.ENTER_FRAME,this.onDoorEffectHandler);
         }
      }
      
      private function onRecorderClickHandler(param1:MouseEvent) : void
      {
         if(this.clickMC)
         {
            if(param1.currentTarget != this.clickMC)
            {
               this.topLevel["pet3"].visible = false;
               DisplayUtil.removeForParent(this.topLevel["pet3"]);
               this.topLevel["pet4"].visible = false;
               DisplayUtil.removeForParent(this.topLevel["pet4"]);
            }
         }
         else
         {
            this.clickMC = param1.currentTarget as SimpleButton;
            this.topLevel["pet1"].visible = false;
            DisplayUtil.removeForParent(this.topLevel["pet1"]);
            this.topLevel["pet2"].visible = false;
            DisplayUtil.removeForParent(this.topLevel["pet2"]);
         }
      }
      
      private function onBossMCClickHandler(param1:MouseEvent) : void
      {
         if(this.bossMC.currentFrame == 2)
         {
            if(MapManager.currentMap.id == 1723)
            {
               getDefinitionByName("com.robot.app2.control.DeepseaLightWarriorController").setup();
               FightBossController.fightBoss("尤纳斯");
            }
            return;
         }
         this.bossMC.gotoAndStop(2);
      }
      
      private function onDoorMCClickHandler(param1:MouseEvent) : void
      {
         if(this.doorMC.hasEventListener(Event.ENTER_FRAME))
         {
            this.doorMC.removeEventListener(Event.ENTER_FRAME,this.onDoorEffectHandler);
         }
         this.doorMC.gotoAndPlay(2);
         this.doorMC.buttonMode = false;
         this.doorMC.mouseEnabled = false;
         this.doorMC.addEventListener(Event.ENTER_FRAME,this.onDoorEffectHandler);
      }
      
      private function onDoorEffectHandler(param1:Event) : void
      {
         if(this.doorMC.currentFrame == this.doorMC.totalFrames)
         {
            this.doorMC.removeEventListener(Event.ENTER_FRAME,arguments.callee);
            this.door0.visible = true;
            this.door1.visible = true;
         }
      }
      
      override public function destroy() : void
      {
         this.removeEvent();
         this.recorder1 = null;
         this.recorder2 = null;
         this.bossMC = null;
         this.doorMC = null;
         this.timer.stop();
         this.timer = null;
         SocketConnection.removeCmdListener(CommandID.SYSTEM_TIME,this.onSystemTime);
         clearTimeout(this.timerID);
      }
   }
}

