package com.robot.app.mapProcess
{
   import com.robot.app.fightLevel.FightPetBagController;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.CommandID;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.info.fightInfo.PetFightModel;
   import com.robot.core.info.fightInfo.attack.FightOverInfo;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.PetManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alarm;
   import com.robot.core.ui.alert.Alert;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import gs.TweenLite;
   import org.taomee.debug.DebugTrace;
   import org.taomee.events.SocketEvent;
   import org.taomee.manager.EventManager;
   import org.taomee.manager.ToolTipManager;
   
   public class MapProcess_10039 extends BaseMapProcess
   {
      
      private static var leftHand_mc:MovieClip;
      
      private static var rightHand_mc:MovieClip;
      
      private static var bossArr:Array;
      
      private static var doorArr:Array;
      
      private static var level2_Anim_mc:MovieClip;
      
      private static var fourBoss_mc:MovieClip;
      
      private static var fourDoor_mc:MovieClip;
      
      private static var power2Appear_mc:MovieClip;
      
      private static var level3_Anim_mc:MovieClip;
      
      private static var level4_Animi_mc:MovieClip;
      
      private static var suc_anim_mc:MovieClip;
      
      private static var isWin:Boolean = false;
      
      public static var isFirstIn:Boolean = true;
      
      private static var level1_over:Boolean = false;
      
      private static var level2_over:Boolean = false;
      
      private static var level3_over:Boolean = false;
      
      private static var level4_over:Boolean = false;
      
      private static var gameOver:Boolean = false;
      
      private static var targetBossID:uint = 0;
      
      private static var targetDoorNum:uint = 0;
      
      private static var BossPosArr:Array = [{
         "_x":260,
         "_y":350
      },{
         "_x":270,
         "_y":314
      },{
         "_x":302,
         "_y":280
      },{
         "_x":338,
         "_y":260
      },{
         "_x":628,
         "_y":260
      },{
         "_x":658,
         "_y":280
      },{
         "_x":692,
         "_y":314
      },{
         "_x":698,
         "_y":350
      }];
      
      private static var appearPosArr:Array = [{
         "_x":180,
         "_y":288
      },{
         "_x":216,
         "_y":234
      },{
         "_x":272,
         "_y":198
      },{
         "_x":338,
         "_y":172
      },{
         "_x":626,
         "_y":172
      },{
         "_x":694,
         "_y":198
      },{
         "_x":748,
         "_y":234
      },{
         "_x":782,
         "_y":288
      }];
      
      private static var levelDoor2Arr:Array = [];
      
      private static var Boss2PosArr:Array = [{
         "_x":264,
         "_y":334
      },{
         "_x":332,
         "_y":264
      },{
         "_x":636,
         "_y":264
      },{
         "_x":696,
         "_y":334
      }];
      
      private static var appear2PosArr:Array = [{
         "_x":198,
         "_y":258
      },{
         "_x":306,
         "_y":184
      },{
         "_x":660,
         "_y":184
      },{
         "_x":772,
         "_y":258
      }];
      
      private var bag_mc:SimpleButton;
      
      private var bigBossAnim_mc:MovieClip;
      
      private var eightDoor_mc:MovieClip;
      
      private var smallBoss_mc:MovieClip;
      
      private var powerAppear_mc:MovieClip;
      
      private var exit_btn:SimpleButton;
      
      private var bubble_mc:MovieClip;
      
      private var bubble2_mc:MovieClip;
      
      public function MapProcess_10039()
      {
         super();
      }
      
      private static function getRandomDoor2Num() : void
      {
         var _loc1_:uint = 0;
         if(levelDoor2Arr.length > 0)
         {
            _loc1_ = Math.random() * levelDoor2Arr.length;
            targetDoorNum = levelDoor2Arr[_loc1_];
            levelDoor2Arr.splice(_loc1_,1);
            DebugTrace.show("doorArr.length:" + levelDoor2Arr.length,"targetDoorNum:" + targetDoorNum);
         }
         else
         {
            DebugTrace.show("二阶段已对战完!");
         }
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86063300);
         ToolBarController.panel.hide();
         LevelManager.iconLevel.visible = false;
         this.initMap();
      }
      
      private function initMap() : void
      {
         this.eightDoor_mc = this.conLevel["eightDoor_mc"];
         this.smallBoss_mc = this.conLevel["smallBoss_mc"];
         this.powerAppear_mc = this.conLevel["powerAppear_mc"];
         leftHand_mc = this.conLevel["leftHand_mc"];
         rightHand_mc = this.conLevel["rightHand_mc"];
         this.bubble_mc = this.conLevel["bubble_mc"];
         this.bubble2_mc = this.conLevel["bubble2_mc"];
         this.bubble_mc.visible = false;
         this.bubble2_mc.visible = false;
         this.powerAppear_mc.gotoAndStop(1);
         this.powerAppear_mc.visible = false;
         this.smallBoss_mc.visible = false;
         rightHand_mc.visible = false;
         leftHand_mc.visible = false;
         level2_Anim_mc = this.animatorLevel["level2_Anim_mc"];
         fourDoor_mc = this.conLevel["fourDoor_mc"];
         fourBoss_mc = this.conLevel["fourBoss_mc"];
         fourBoss_mc.visible = false;
         fourDoor_mc.visible = false;
         power2Appear_mc = this.conLevel["power2Appear_mc"];
         power2Appear_mc.visible = false;
         level3_Anim_mc = this.conLevel["level3_Anim_mc"];
         level3_Anim_mc.visible = false;
         level4_Animi_mc = this.conLevel["level4_Anim_mc"];
         level4_Animi_mc.visible = false;
         this.exit_btn = conLevel["exit_btn"];
         this.exit_btn.addEventListener(MouseEvent.CLICK,this.onExit);
         ToolTipManager.add(this.exit_btn,"空间裂缝");
         this.bag_mc = conLevel["bag_mc"];
         ToolTipManager.add(this.bag_mc,"精灵背包");
         this.bag_mc.addEventListener(MouseEvent.CLICK,this.onBagClick);
         if(isFirstIn)
         {
            this.exit_btn.visible = this.bag_mc.visible = false;
            this.loadFallSwf();
            isFirstIn = false;
            this.initBossArr();
            this.initDoorArr();
            this.eightDoor_mc.visible = false;
         }
         else
         {
            MainManager.actorModel.x = 480;
            MainManager.actorModel.y = 440;
         }
         this.addEvent();
      }
      
      private function onBagClick(param1:MouseEvent) : void
      {
         FightPetBagController.show();
      }
      
      private function initBossArr() : void
      {
         var _loc1_:uint = 12;
         bossArr = [];
         var _loc2_:uint = 1;
         while(_loc2_ <= _loc1_)
         {
            bossArr.push(_loc2_);
            _loc2_++;
         }
      }
      
      private function initDoorArr() : void
      {
         var _loc1_:uint = 8;
         doorArr = [];
         var _loc2_:uint = 1;
         while(_loc2_ <= _loc1_)
         {
            doorArr.push(_loc2_);
            _loc2_++;
         }
      }
      
      private function getRandomBossNum() : uint
      {
         var _loc1_:uint = 0;
         if(bossArr.length > 0)
         {
            _loc1_ = Math.random() * bossArr.length;
            targetBossID = bossArr[_loc1_];
            bossArr.splice(_loc1_,1);
            DebugTrace.show("targetBossID:" + targetBossID);
            return targetBossID;
         }
         DebugTrace.show("一阶段已对战完!");
         return 0;
      }
      
      private function getRandomDoorNum() : uint
      {
         var _loc1_:uint = 0;
         if(doorArr.length > 0)
         {
            _loc1_ = Math.random() * doorArr.length;
            targetDoorNum = doorArr[_loc1_];
            doorArr.splice(_loc1_,1);
            DebugTrace.show("doorArr.length:" + doorArr.length,"targetDoorNum:" + targetDoorNum);
            return targetBossID;
         }
         DebugTrace.show("一阶段已对战完!");
         return 0;
      }
      
      private function loadFallSwf() : void
      {
         AnimateManager.playFullScreenAnimate(ClientConfig.getFullMovie("DemonSpaceSwf_1"),function():void
         {
            MainManager.actorModel.pos = new Point(480,120);
            TweenLite.to(MainManager.actorModel,0.5,{
               "x":480,
               "y":440,
               "onComplete":onTweenCmp
            });
         });
      }
      
      private function onTweenCmp() : void
      {
         this.bigBossAnim_mc = animatorLevel["bigBossAnim_mc"];
         this.bigBossAnim_mc.addEventListener(Event.ENTER_FRAME,this.onBigBossAnimEnterFrame);
         this.bigBossAnim_mc.gotoAndPlay(2);
         MapManager.currentMap.spaceLevel.visible = false;
      }
      
      private function onBigBossAnimEnterFrame(param1:Event) : void
      {
         if(this.bigBossAnim_mc.totalFrames == this.bigBossAnim_mc.currentFrame)
         {
            this.exit_btn.visible = this.bag_mc.visible = true;
            this.bigBossAnim_mc.gotoAndStop(1);
            this.bigBossAnim_mc.removeEventListener(Event.ENTER_FRAME,this.onBigBossAnimEnterFrame);
            this.showEightDoor();
            MapManager.currentMap.spaceLevel.visible = true;
         }
      }
      
      private function showEightDoor() : void
      {
         this.eightDoor_mc.visible = true;
         this.getRandomDoorNum();
         if(targetDoorNum > 4)
         {
            this.powerAppear_mc.scaleX = -1;
            leftHand_mc.visible = true;
            leftHand_mc.addEventListener(Event.ENTER_FRAME,this.onLeftHandFrame);
            leftHand_mc.gotoAndPlay(2);
         }
         else
         {
            rightHand_mc.visible = true;
            rightHand_mc.addEventListener(Event.ENTER_FRAME,this.onRightHandFrame);
            rightHand_mc.gotoAndPlay(2);
         }
      }
      
      private function onLeftHandFrame(param1:Event) : void
      {
         if(leftHand_mc.currentFrame == leftHand_mc.totalFrames)
         {
            leftHand_mc.removeEventListener(Event.ENTER_FRAME,this.onLeftHandFrame);
            this.showPowerAppear();
         }
      }
      
      private function onRightHandFrame(param1:Event) : void
      {
         if(rightHand_mc.currentFrame == rightHand_mc.totalFrames)
         {
            rightHand_mc.removeEventListener(Event.ENTER_FRAME,this.onRightHandFrame);
            this.showPowerAppear();
         }
      }
      
      private function showPowerAppear() : void
      {
         this.powerAppear_mc.x = appearPosArr[targetDoorNum - 1]._x;
         this.powerAppear_mc.y = appearPosArr[targetDoorNum - 1]._y;
         this.powerAppear_mc.visible = true;
         this.powerAppear_mc.addEventListener(Event.ENTER_FRAME,this.onPowerAppearFrame);
         this.powerAppear_mc.gotoAndPlay(2);
      }
      
      private function onPowerAppearFrame(param1:Event) : void
      {
         if(this.powerAppear_mc.currentFrame == this.powerAppear_mc.totalFrames)
         {
            this.powerAppear_mc.gotoAndStop(1);
            this.powerAppear_mc.visible = false;
            this.powerAppear_mc.removeEventListener(Event.ENTER_FRAME,this.onPowerAppearFrame);
            this.showBoss();
         }
      }
      
      private function showBoss() : void
      {
         this.smallBoss_mc.visible = true;
         var _loc1_:uint = this.getRandomBossNum();
         this.smallBoss_mc.gotoAndStop(_loc1_);
         this.smallBoss_mc.x = BossPosArr[targetDoorNum - 1]._x;
         this.smallBoss_mc.y = BossPosArr[targetDoorNum - 1]._y;
         this.bubble_mc.visible = true;
         this.bubble_mc.x = this.smallBoss_mc.x - 46;
         this.bubble_mc.y = this.smallBoss_mc.y - 136;
         this.bubble_mc.gotoAndStop(targetDoorNum);
         this.smallBoss_mc.addEventListener(MouseEvent.CLICK,this.sendChallengeBoss);
         this.smallBoss_mc.buttonMode = true;
      }
      
      private function showBoss2() : void
      {
         fourBoss_mc.visible = true;
         fourBoss_mc.gotoAndStop(targetDoorNum);
         fourBoss_mc.x = Boss2PosArr[targetDoorNum - 1]._x;
         fourBoss_mc.y = Boss2PosArr[targetDoorNum - 1]._y;
         this.bubble2_mc.visible = true;
         this.bubble2_mc.x = fourBoss_mc.x - 46;
         this.bubble2_mc.y = fourBoss_mc.y - 136;
         this.bubble2_mc.gotoAndStop(targetDoorNum);
         targetBossID = targetDoorNum;
         fourBoss_mc.addEventListener(MouseEvent.CLICK,this.sendChallengeBoss);
         fourBoss_mc.buttonMode = true;
      }
      
      private function addEvent() : void
      {
         SocketConnection.addCmdListener(CommandID.CHALLENGE_GHOST,this.onChallengeGhost);
         SocketConnection.addCmdListener(CommandID.EXIT_GHOST_SPACE,this.onExitGhostSpace);
         FightDispatcher.addEventListener(PetFightEvent.FIGHT_RESULT,this.onFightComplete);
         EventManager.addEventListener(RobotEvent.FIGHT_OVER_UI_CLEAN,this.onUIClean);
         EventManager.addEventListener(RobotEvent.NO_PET_CAN_FIGHT,this.onQuit);
      }
      
      private function sendChallengeBoss(param1:MouseEvent) : void
      {
         DebugTrace.show("对战BOSS 号：" + targetBossID);
         PetFightModel.mode = PetFightModel.MULTI_MODE;
         PetFightModel.type = PetFightModel.FIGHT_DEMON_SPACE;
         SocketConnection.send(CommandID.CHALLENGE_GHOST,targetBossID);
      }
      
      private function onChallengeGhost(param1:SocketEvent) : void
      {
         SocketConnection.removeCmdListener(CommandID.CHALLENGE_GHOST,this.onChallengeGhost);
      }
      
      private function onFightComplete(param1:PetFightEvent) : void
      {
         FightDispatcher.removeEventListener(PetFightEvent.FIGHT_RESULT,this.onFightComplete);
         var _loc2_:FightOverInfo = param1.dataObj as FightOverInfo;
         if(_loc2_.winnerID == MainManager.actorID)
         {
            isWin = true;
         }
         else
         {
            isWin = false;
         }
      }
      
      private function onUIClean(param1:RobotEvent) : void
      {
         if(isWin)
         {
            if(doorArr.length == 0 && !level1_over)
            {
               level1_over = true;
               this.level2Operate();
            }
            else if(!level1_over)
            {
               this.showEightDoor();
            }
            else if(level1_over && levelDoor2Arr.length == 0 && !level2_over)
            {
               level2_over = true;
               this.level3Operate();
            }
            else if(!level2_over)
            {
               this.showLevel2Door();
            }
            else if(level1_over && level2_over && !level3_over)
            {
               level3_over = true;
               this.level4Operate();
            }
            else if(level3_over)
            {
               gameOver = true;
               this.playSucAni();
            }
         }
         else
         {
            this.onFailExit();
         }
      }
      
      private function level2Operate() : void
      {
         SocketConnection.addCmdListener(CommandID.ENTER_NEXT_STAGE,function(param1:SocketEvent):void
         {
            SocketConnection.removeCmdListener(CommandID.ENTER_NEXT_STAGE,arguments.callee);
            eightDoor_mc.visible = false;
            level2_Anim_mc.gotoAndPlay(2);
            level2_Anim_mc.addEventListener(Event.ENTER_FRAME,onLevel2Operate);
         });
         SocketConnection.send(CommandID.ENTER_NEXT_STAGE);
      }
      
      private function onLevel2Operate(param1:Event) : void
      {
         if(level2_Anim_mc.totalFrames == level2_Anim_mc.currentFrame)
         {
            level2_Anim_mc.removeEventListener(Event.ENTER_FRAME,this.onLevel2Operate);
            level2_Anim_mc.gotoAndStop(level2_Anim_mc.totalFrames);
            fourDoor_mc.visible = true;
            this.initDoor2Arr();
            this.showLevel2Door();
         }
      }
      
      private function initDoor2Arr() : void
      {
         var _loc1_:uint = 4;
         levelDoor2Arr = [];
         var _loc2_:uint = 1;
         while(_loc2_ <= _loc1_)
         {
            levelDoor2Arr.push(_loc2_);
            _loc2_++;
         }
      }
      
      private function showLevel2Door() : void
      {
         getRandomDoor2Num();
         fourDoor_mc.visible = true;
         this.eightDoor_mc.visible = false;
         if(targetDoorNum > 2)
         {
            power2Appear_mc.scaleX = -1;
            leftHand_mc.visible = true;
            leftHand_mc.addEventListener(Event.ENTER_FRAME,this.onLeftHandFrame2);
            leftHand_mc.gotoAndPlay(2);
         }
         else
         {
            rightHand_mc.visible = true;
            rightHand_mc.addEventListener(Event.ENTER_FRAME,this.onRightHandFrame2);
            rightHand_mc.gotoAndPlay(2);
         }
      }
      
      private function onLeftHandFrame2(param1:Event) : void
      {
         if(leftHand_mc.currentFrame == leftHand_mc.totalFrames)
         {
            leftHand_mc.removeEventListener(Event.ENTER_FRAME,this.onLeftHandFrame2);
            this.showPower2Appear();
         }
      }
      
      private function onRightHandFrame2(param1:Event) : void
      {
         if(rightHand_mc.currentFrame == rightHand_mc.totalFrames)
         {
            rightHand_mc.removeEventListener(Event.ENTER_FRAME,this.onRightHandFrame2);
            this.showPower2Appear();
         }
      }
      
      private function showPower2Appear() : void
      {
         power2Appear_mc.x = appear2PosArr[targetDoorNum - 1]._x;
         power2Appear_mc.y = appear2PosArr[targetDoorNum - 1]._y;
         power2Appear_mc.visible = true;
         power2Appear_mc.addEventListener(Event.ENTER_FRAME,this.onPower2AppearFrame);
         power2Appear_mc.gotoAndPlay(2);
      }
      
      private function onPower2AppearFrame(param1:Event) : void
      {
         if(power2Appear_mc.currentFrame == power2Appear_mc.totalFrames)
         {
            power2Appear_mc.gotoAndStop(1);
            power2Appear_mc.visible = false;
            power2Appear_mc.removeEventListener(Event.ENTER_FRAME,this.onPower2AppearFrame);
            this.showBoss2();
         }
      }
      
      private function level3Operate() : void
      {
         SocketConnection.addCmdListener(CommandID.ENTER_NEXT_STAGE,function(param1:SocketEvent):void
         {
            SocketConnection.removeCmdListener(CommandID.ENTER_NEXT_STAGE,arguments.callee);
            DebugTrace.show("进入第三阶段");
            targetBossID = 1;
            fourDoor_mc.visible = false;
            eightDoor_mc.visible = false;
            level3_Anim_mc.visible = true;
            level3_Anim_mc.gotoAndPlay(2);
            level3_Anim_mc.addEventListener(Event.ENTER_FRAME,onLevel3_Anim_mcFrame);
         });
         SocketConnection.send(CommandID.ENTER_NEXT_STAGE);
      }
      
      private function onLevel3_Anim_mcFrame(param1:Event) : void
      {
         if(level3_Anim_mc.currentFrame == level3_Anim_mc.totalFrames)
         {
            level3_Anim_mc.gotoAndStop(level3_Anim_mc.currentFrame);
            level3_Anim_mc.removeEventListener(Event.ENTER_FRAME,this.onLevel3_Anim_mcFrame);
            level4_Animi_mc.mouseChildren = false;
            level4_Animi_mc.mouseEnabled = false;
            level3_Anim_mc.addEventListener(MouseEvent.CLICK,this.sendChallengeBoss);
            level3_Anim_mc.buttonMode = true;
         }
      }
      
      private function level4Operate() : void
      {
         SocketConnection.addCmdListener(CommandID.ENTER_NEXT_STAGE,function(param1:SocketEvent):void
         {
            SocketConnection.removeCmdListener(CommandID.ENTER_NEXT_STAGE,arguments.callee);
            DebugTrace.show("进入第四阶段");
            targetBossID = 1;
            fourDoor_mc.visible = false;
            eightDoor_mc.visible = false;
            level3_Anim_mc.visible = false;
            level4_Animi_mc.visible = true;
            level4_Animi_mc.gotoAndPlay(2);
            level4_Animi_mc.addEventListener(Event.ENTER_FRAME,onLevel4_Anim_mcFrame);
         });
         SocketConnection.send(CommandID.ENTER_NEXT_STAGE);
      }
      
      private function onLevel4_Anim_mcFrame(param1:Event) : void
      {
         if(level4_Animi_mc.currentFrame == level4_Animi_mc.totalFrames)
         {
            level4_Animi_mc.gotoAndStop(level4_Animi_mc.totalFrames);
            level4_Animi_mc.removeEventListener(Event.ENTER_FRAME,this.onLevel4_Anim_mcFrame);
            level4_Animi_mc.addEventListener(MouseEvent.CLICK,this.sendChallengeBoss);
            level4_Animi_mc.buttonMode = true;
         }
      }
      
      private function playSucAni() : void
      {
         fourDoor_mc.visible = false;
         this.eightDoor_mc.visible = false;
         suc_anim_mc = this.conLevel["suc_anim_mc"];
         suc_anim_mc.visible = true;
         suc_anim_mc.addEventListener(Event.ENTER_FRAME,this.onSucFrame);
         suc_anim_mc.gotoAndPlay(2);
      }
      
      private function onSucFrame(param1:Event) : void
      {
         if(suc_anim_mc.currentFrame == suc_anim_mc.totalFrames)
         {
            suc_anim_mc.removeEventListener(Event.ENTER_FRAME,this.onSucFrame);
            if(PetManager.containsBagForID(695))
            {
               ModuleManager.showModule(ClientConfig.getAppModule("GhostSpaceAdvanceSkill"),"正在打开...",695);
            }
            else
            {
               SocketConnection.send(CommandID.EXIT_GHOST_SPACE);
            }
         }
      }
      
      private function onExit(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         Alert.show("再次进入时需要重新挑战，确定要离开伏魔空间吗？",function():void
         {
            SocketConnection.send(CommandID.EXIT_GHOST_SPACE);
         });
      }
      
      private function onFailExit() : void
      {
         Alarm.show("非常可惜，你被打败了！",function():void
         {
            SocketConnection.send(CommandID.EXIT_GHOST_SPACE);
         });
      }
      
      private function onQuit(param1:RobotEvent) : void
      {
      }
      
      private function onExitGhostSpace(param1:SocketEvent) : void
      {
         SocketConnection.removeCmdListener(CommandID.EXIT_GHOST_SPACE,this.onExitGhostSpace);
         ToolBarController.panel.show();
         LevelManager.iconLevel.visible = true;
         isFirstIn = true;
         PetFightModel.type = 0;
         level1_over = level2_over = level3_over = level4_over = gameOver = false;
         MapManager.changeMap(14);
      }
      
      private function removeEvent() : void
      {
         SocketConnection.removeCmdListener(CommandID.CHALLENGE_GHOST,this.onChallengeGhost);
         SocketConnection.removeCmdListener(CommandID.EXIT_GHOST_SPACE,this.onExitGhostSpace);
         EventManager.removeEventListener(RobotEvent.FIGHT_OVER_UI_CLEAN,this.onUIClean);
         EventManager.removeEventListener(RobotEvent.NO_PET_CAN_FIGHT,this.onQuit);
         if(fourBoss_mc)
         {
            fourBoss_mc.removeEventListener(MouseEvent.CLICK,this.sendChallengeBoss);
         }
         if(this.smallBoss_mc)
         {
            this.smallBoss_mc.removeEventListener(MouseEvent.CLICK,this.sendChallengeBoss);
         }
         if(this.bigBossAnim_mc)
         {
            this.bigBossAnim_mc.removeEventListener(Event.ENTER_FRAME,this.onBigBossAnimEnterFrame);
         }
         if(level2_Anim_mc)
         {
            level2_Anim_mc.removeEventListener(Event.ENTER_FRAME,this.onLevel2Operate);
         }
         if(level3_Anim_mc)
         {
            level3_Anim_mc.removeEventListener(Event.ENTER_FRAME,this.onLevel3_Anim_mcFrame);
         }
         if(level4_Animi_mc)
         {
            level4_Animi_mc.removeEventListener(Event.ENTER_FRAME,this.onLevel4_Anim_mcFrame);
         }
         if(power2Appear_mc)
         {
            power2Appear_mc.removeEventListener(Event.ENTER_FRAME,this.onPower2AppearFrame);
         }
         if(suc_anim_mc)
         {
            suc_anim_mc.removeEventListener(Event.ENTER_FRAME,this.onSucFrame);
         }
         if(leftHand_mc)
         {
            leftHand_mc.removeEventListener(Event.ENTER_FRAME,this.onLeftHandFrame);
            leftHand_mc.removeEventListener(Event.ENTER_FRAME,this.onLeftHandFrame2);
         }
         if(rightHand_mc)
         {
            rightHand_mc.removeEventListener(Event.ENTER_FRAME,this.onRightHandFrame);
            rightHand_mc.removeEventListener(Event.ENTER_FRAME,this.onRightHandFrame2);
         }
         if(this.bag_mc)
         {
            this.bag_mc.removeEventListener(MouseEvent.CLICK,this.onBagClick);
         }
         if(level4_Animi_mc)
         {
            level4_Animi_mc.removeEventListener(MouseEvent.CLICK,this.sendChallengeBoss);
         }
         if(level3_Anim_mc)
         {
            level3_Anim_mc.removeEventListener(MouseEvent.CLICK,this.sendChallengeBoss);
         }
         this.exit_btn.removeEventListener(MouseEvent.CLICK,this.onExit);
      }
      
      override public function destroy() : void
      {
         this.removeEvent();
         ToolTipManager.remove(this.bag_mc);
         ToolTipManager.remove(this.exit_btn);
         MapManager.currentMap.spaceLevel.visible = true;
      }
   }
}

