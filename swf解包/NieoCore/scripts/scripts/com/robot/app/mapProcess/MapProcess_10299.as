package com.robot.app.mapProcess
{
   import com.robot.app.panel.MapNamePanel;
   import com.robot.app.panel.PetChoosePanel;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.CommandID;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.config.xml.PetXMLInfo;
   import com.robot.core.info.pet.PetInfo;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.PetManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NpcDialog;
   import com.robot.core.ui.alert.Alarm;
   import com.robot.core.utils.TextFormatUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.net.SharedObject;
   import flash.text.TextField;
   import flash.utils.Timer;
   import flash.utils.getDefinitionByName;
   import flash.utils.setTimeout;
   
   public class MapProcess_10299 extends BaseMapProcess
   {
      
      private static const LOCAL_DATA_NAME:String = "SageluosiActivityControllerLocalData";
      
      private static const WIDTH:int = 378;
      
      private static const HEIGHT:int = 180;
      
      private static const TOTAL_SENCONDS:int = 120;
      
      private static const DAILY_ID_CURRENT_PROGRESS:uint = 11551;
      
      private var _total:int;
      
      private var _currentHit:int;
      
      private var _leftSnds:int;
      
      private var _isWin:Boolean;
      
      private var _currentLv:int;
      
      private var _timerHit:Timer;
      
      private var _beHitted:Boolean;
      
      private var _timerLeft:Timer;
      
      private var cls:*;
      
      public function MapProcess_10299()
      {
         super();
      }
      
      private static function getEvArrayId(param1:int) : int
      {
         var _loc2_:int = 0;
         if(param1 == 0)
         {
            return 5;
         }
         return param1 - 1;
      }
      
      override protected function init() : void
      {
         ToolBarController.panel.hide();
         LevelManager.iconLevel.visible = false;
         LevelManager.toolsLevel.visible = false;
         MapListenerManager.add(topLevel["bag"],this.onBag,"精灵背包");
         MapListenerManager.add(conLevel["devices"],this.onClick);
         (topLevel["mcHitMe"] as MovieClip).visible = false;
         (conLevel["devices"] as MovieClip).visible = false;
         this.cls = getDefinitionByName("com.robot.app2.mapProcess.control.SageluosiActivityController");
         this.cls.init(this);
         KTool.getLimitNum(DAILY_ID_CURRENT_PROGRESS,function(param1:int):void
         {
            _currentLv = param1 + 1;
            if(_currentLv > 1 || getLocalData() >= 1)
            {
               (conLevel["animationContainer"] as MovieClip).visible = false;
               (conLevel["devices"] as MovieClip).visible = false;
               playEffect();
            }
            else
            {
               playMovie(1);
            }
         });
      }
      
      private function playEffect() : void
      {
         (topLevel["level"] as MovieClip).visible = true;
         (topLevel["level"] as MovieClip).gotoAndStop(this._currentLv);
         (topLevel["effect"] as MovieClip).addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         (topLevel["effect"] as MovieClip).gotoAndPlay(1);
      }
      
      private function playMovie(param1:int) : void
      {
         var frame:int = param1;
         KTool.hideMapAllPlayerAndMonster();
         (topLevel["level"] as MovieClip).visible = false;
         (conLevel["devices"] as MovieClip).visible = false;
         AnimateManager.playMcAnimate(conLevel["animationContainer"],frame,"mc" + frame,function():void
         {
            (conLevel["animationContainer"] as MovieClip).visible = false;
            KTool.showMapAllPlayerAndMonster();
            writeLocalData(frame);
            _currentLv = 1;
            playEffect();
         });
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         if(_loc2_.currentFrame >= _loc2_.totalFrames)
         {
            _loc2_.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            (topLevel["level"] as MovieClip).visible = false;
            (topLevel["effect"] as MovieClip).gotoAndStop(1);
            (conLevel["devices"] as MovieClip).visible = true;
            if(this._currentLv == 10)
            {
               (conLevel["devices"] as MovieClip).gotoAndStop(6);
            }
            else if(this._currentLv == 11)
            {
               (conLevel["devices"] as MovieClip).gotoAndStop(7);
            }
            else
            {
               (conLevel["devices"] as MovieClip).gotoAndStop(this._currentLv % 5 == 0 ? 5 : this._currentLv % 5);
            }
         }
      }
      
      private function getLocalData() : int
      {
         var _loc1_:SharedObject = SharedObject.getLocal(LOCAL_DATA_NAME);
         if(null == _loc1_)
         {
            return 0;
         }
         return _loc1_.data[MainManager.actorID];
      }
      
      private function writeLocalData(param1:int) : void
      {
         var _loc2_:SharedObject = SharedObject.getLocal(LOCAL_DATA_NAME);
         if(null == _loc2_)
         {
            _loc2_ = new SharedObject();
         }
         _loc2_.data[MainManager.actorID] = param1;
         _loc2_.flush();
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         var mc:MovieClip = e.currentTarget as MovieClip;
         if(null == mc)
         {
            return;
         }
         if(11 == this._currentLv)
         {
            ModuleManager.showModule(ClientConfig.getAppModule("SageluosiCreditPanel"));
            return;
         }
         if(10 == this._currentLv)
         {
            NpcDialog.show(2256,[MainManager.actorInfo.formatNick + "，你将迎来最终的试炼，希望你能顺利通过这次挑战！"],["我准备好了，放马过来吧！"],[function():void
            {
               ModuleManager.showModule(ClientConfig.getAppModule("SageluosiFightPanel"),"正在打开...",_currentLv);
            }]);
            return;
         }
         if((this._currentLv == 2 || this._currentLv == 7) && this.cls.GetCdTime() > 0)
         {
            NpcDialog.show(2255,["哼！连这种题都不会！0xff0000" + this.cls.GetCdTime() + "0xffffff秒内别找我说话！"],["不要生气嘛！我……我过会再来找你！"],[function():void
            {
            }]);
            return;
         }
         ModuleManager.showModule(ClientConfig.getAppModule("SageluosiFightPanel"),"正在打开...",this._currentLv);
      }
      
      public function startFirst() : void
      {
         KTool.hideMapAllPlayerAndMonster();
         (conLevel["animationContainer"] as MovieClip).visible = true;
         (conLevel["devices"] as MovieClip).visible = false;
         AnimateManager.playMcAnimate(conLevel["animationContainer"],2,"mc2",function():void
         {
            (conLevel["animationContainer"] as MovieClip).visible = false;
            writeLocalData(2);
            _total = _currentLv == 1 ? 15 : 30;
            _leftSnds = TOTAL_SENCONDS;
            (topLevel["bag"] as SimpleButton).visible = false;
            (conLevel["devices"] as MovieClip).visible = false;
            _timerHit = new Timer(2000);
            _timerHit.addEventListener(TimerEvent.TIMER,onTimerHit);
            _timerHit.start();
            _currentHit = 0;
            MapListenerManager.add(topLevel["mcHitMe"]["mcStar"],onStar);
            (topLevel["mcHitMe"] as MovieClip).visible = true;
            randomDevice();
            MapNamePanel.hide();
            _timerLeft = new Timer(1000);
            _timerLeft.addEventListener(TimerEvent.TIMER,onTimerLeft);
            _timerLeft.start();
            updateLeftTime();
            updateHit();
         });
      }
      
      private function randomDevice() : void
      {
         var mc:MovieClip = topLevel["mcHitMe"]["mcStar"] as MovieClip;
         mc.visible = true;
         mc.gotoAndStop(1);
         mc.x = -209 + Math.random() * WIDTH;
         mc.y = -149 + Math.random() * HEIGHT;
         MovieClip(topLevel["mcHitMe"]["mcStar"]).mouseEnabled = true;
         MovieClip(topLevel["mcHitMe"]["mcStar"]).mouseChildren = true;
         this._beHitted = false;
         setTimeout(function():void
         {
            if(!_beHitted)
            {
               (topLevel["mcHitMe"]["mcStar"] as MovieClip).visible = false;
            }
         },this._currentLv == 1 ? 600 : 500);
      }
      
      private function updateHit() : void
      {
         (topLevel["mcHitMe"]["mcFight"]["txtLeftTimes"] as TextField).text = this._currentHit + "/" + this._total;
      }
      
      private function onTimerLeft(param1:TimerEvent) : void
      {
         --this._leftSnds;
         if(this._leftSnds <= 0)
         {
            this._isWin = false;
            this.stopRandom();
            StatManager.sendStat2014("黑螳螂的试炼（万圣版）","第1关试炼失败",StatManager.RUN_ACT);
            return;
         }
         this.updateLeftTime();
      }
      
      public function updateStage() : void
      {
         KTool.getLimitNum(DAILY_ID_CURRENT_PROGRESS,function(param1:int):void
         {
            _currentLv = param1 + 1;
            playEffect();
         });
      }
      
      private function stopRandom() : void
      {
         this._timerLeft.stop();
         this._timerLeft.removeEventListener(TimerEvent.TIMER,this.onTimerLeft);
         this._timerHit.stop();
         this._timerHit.removeEventListener(TimerEvent.TIMER,this.onTimerHit);
         MapListenerManager.remove(topLevel["mcHitMe"]["mcStar"]);
         SocketConnection.sendWithCallback(41544,function():void
         {
            if(_isWin)
            {
               StatManager.sendStat2014("黑螳螂的试炼（万圣版）","第1关试炼成功",StatManager.RUN_ACT);
               NpcDialog.show(2262,[MainManager.actorInfo.formatNick + "，你的反应速度初步达到了我的标准。这30点学习力作为我对你这次表现的奖励！不过不要骄傲哦，用更好的表现来面对我下一次的考验吧！"],["谢谢！我一定会加油的！"],[openStudyPanel]);
            }
            else
            {
               NpcDialog.show(2262,[MainManager.actorInfo.formatNick + "，你的反应速度还有待提高啊。不过不要气馁，送你20点学习力，付出辛苦总会有收获的！"],["谢谢！我一定会加油的！"],[openStudyPanel]);
            }
         },this._currentLv,this._currentHit >= this._total ? 1 : 0);
      }
      
      private function updateLeftTime() : void
      {
         var _loc1_:int = int(this._leftSnds / 60);
         var _loc2_:int = this._leftSnds - _loc1_ * 60;
         KTool.showScore(topLevel["mcHitMe"]["mcFight"]["mcMins"],_loc1_,0,true);
         KTool.showScore(topLevel["mcHitMe"]["mcFight"]["mcSnds"],_loc2_,0,true);
      }
      
      private function onTimerHit(param1:TimerEvent) : void
      {
         this.randomDevice();
      }
      
      private function openStudyPanel() : void
      {
         var func:Function = null;
         func = function():void
         {
            KTool.showMapAllPlayerAndMonster(true);
            MapNamePanel.show();
            (topLevel["bag"] as SimpleButton).visible = true;
            (topLevel["mcHitMe"] as MovieClip).visible = false;
            updateStage();
         };
         PetChoosePanel.show(function(param1:PetInfo):void
         {
            var info:PetInfo = param1;
            var obj:Object = {
               "name":PetXMLInfo.getName(info.id),
               "fun":function(param1:int, param2:String):void
               {
                  var id:int = param1;
                  var abilityName:String = param2;
                  SocketConnection.addCmdListener(CommandID.NEW_LEARNING_ABILITY,function():void
                  {
                     SocketConnection.removeCmdListener(CommandID.NEW_LEARNING_ABILITY,arguments.callee);
                     PetManager.upDateBagPetInfo(info.catchTime,function(param1:PetInfo):void
                     {
                        if(MainManager.actorInfo.superNono)
                        {
                           Alarm.show("恭喜你，你因为VIP的尊贵身份" + TextFormatUtil.getRedTxt("额外获得了10学习力") + "，" + TextFormatUtil.getRedTxt(PetXMLInfo.getName(info.id)) + "的" + abilityName + "学习力由" + TextFormatUtil.getRedTxt(info.evArray[getEvArrayId(id)].toString()) + "提高至了" + TextFormatUtil.getRedTxt(param1.evArray[getEvArrayId(id)].toString()) + "！",func);
                        }
                        else
                        {
                           Alarm.show("恭喜你，" + TextFormatUtil.getRedTxt(PetXMLInfo.getName(info.id)) + "的" + abilityName + "由" + TextFormatUtil.getRedTxt(info.evArray[getEvArrayId(id)].toString()) + "提高至了" + TextFormatUtil.getRedTxt(param1.evArray[getEvArrayId(id)].toString()) + "！",func);
                        }
                     });
                  });
                  SocketConnection.send(CommandID.NEW_LEARNING_ABILITY,info.catchTime,id,_currentLv);
               },
               "petInfo":info,
               "time":_currentLv - 1,
               "isWin":_isWin,
               "closeFunc":openStudyPanel
            };
            ModuleManager.showModule(ClientConfig.getAppModule("LearningabilityInjectPanel"),"正在加载....",obj);
         },func,null,7);
      }
      
      private function onStar(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         (topLevel["mcHitMe"]["mcStar"] as MovieClip).gotoAndStop(2);
         setTimeout(function():void
         {
            (topLevel["mcHitMe"]["mcStar"] as MovieClip).visible = false;
         },1000);
         ++this._currentHit;
         this._beHitted = true;
         this.updateHit();
         MovieClip(topLevel["mcHitMe"]["mcStar"]).mouseEnabled = false;
         MovieClip(topLevel["mcHitMe"]["mcStar"]).mouseChildren = false;
         if(this._currentHit >= this._total)
         {
            this._isWin = true;
            this.stopRandom();
         }
      }
      
      private function onBag(param1:MouseEvent) : void
      {
         ModuleManager.showModule(ClientConfig.getAppModule("ADPetBagPanelNew"));
      }
      
      public function leave() : void
      {
         MapManager.changeMap(102);
      }
      
      override public function destroy() : void
      {
         if(null != this._timerHit)
         {
            if(this._timerHit.running)
            {
               this._timerHit.stop();
            }
            this._timerHit.removeEventListener(TimerEvent.TIMER,this.onTimerHit);
         }
         if(null != this._timerLeft)
         {
            if(this._timerLeft.running)
            {
               this._timerLeft.stop();
            }
            this._timerLeft.removeEventListener(TimerEvent.TIMER,this.onTimerLeft);
         }
         MapListenerManager.remove(topLevel["mcHitMe"]["mcStar"]);
         MapListenerManager.remove(topLevel["bag"]);
         MapListenerManager.remove(conLevel["devices"]);
         ToolBarController.panel.show();
         this.cls.destroy();
         LevelManager.iconLevel.visible = true;
         LevelManager.toolsLevel.visible = true;
      }
   }
}

