package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.fightLevel.FightPetBagController;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.CommandID;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.info.fightInfo.attack.FightOverInfo;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alarm;
   import com.robot.core.ui.alert.Alert;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import org.taomee.events.SocketEvent;
   import org.taomee.manager.EventManager;
   import org.taomee.manager.ToolTipManager;
   
   public class MapProcess_10032 extends BaseMapProcess
   {
      
      private static var doorindex:uint = 0;
      
      private const OPEN_LEVEL:uint = 2;
      
      private var currentMC:MovieClip;
      
      private var doornum:uint = 7;
      
      private var _type:uint = 0;
      
      public function MapProcess_10032()
      {
         super();
      }
      
      override protected function init() : void
      {
         var i:uint;
         var t1:uint = 0;
         ToolBarController.panel.hide();
         LevelManager.iconLevel.visible = false;
         ToolTipManager.add(conLevel["door_0"],"离开");
         depthLevel["mhtHitMc"].buttonMode = true;
         ToolTipManager.add(depthLevel["mhtHitMc"],"谱尼");
         ToolTipManager.add(conLevel["bagMc"],"精灵背包");
         conLevel["bagMc"].addEventListener(MouseEvent.CLICK,this.onBagHandler);
         depthLevel["mhtHitMc"].addEventListener(MouseEvent.CLICK,this.onMhtClickHandler);
         i = 0;
         while(i < this.doornum)
         {
            if(MainManager.actorInfo.dailyResArr[40 + i] == false)
            {
               conLevel["cachetMc_" + i].gotoAndStop(1);
            }
            else
            {
               conLevel["cachetMc_" + i].gotoAndStop(3);
            }
            i++;
         }
         if(MainManager.actorInfo.maxPuniLv >= 7)
         {
            depthLevel["hh"].gotoAndStop(2);
         }
         EventManager.addEventListener(RobotEvent.ERROR_11027,this.onError11027Handler);
         EventManager.addEventListener(RobotEvent.ERROR_11028,this.onError11028Handler);
         if(doorindex == 7)
         {
            t1 = setTimeout(function():void
            {
               clearTimeout(t1);
               AnimateManager.playMcAnimate(depthLevel["out_effect"],0,"",function():void
               {
               });
            },5000);
         }
         if(TasksManager.getTaskStatus(298) == TasksManager.COMPLETE)
         {
            if(TasksManager.getTaskStatus(517) == TasksManager.ALR_ACCEPT)
            {
               TasksManager.complete(517,0,function(param1:Boolean):void
               {
               });
            }
            else if(TasksManager.getTaskStatus(517) == TasksManager.UN_ACCEPT)
            {
               TasksManager.accept(517,function(param1:Boolean):void
               {
                  if(param1)
                  {
                     TasksManager.setTaskStatus(517,TasksManager.ALR_ACCEPT);
                     TasksManager.complete(517,0);
                  }
                  else
                  {
                     Alarm.show("接受任务失败，请稍后再试！");
                  }
               });
            }
         }
      }
      
      private function onError11027Handler(param1:RobotEvent) : void
      {
         FightDispatcher.removeEventListener(PetFightEvent.FIGHT_CLOSE,this.onCloseFight);
         switch(doorindex)
         {
            case 1:
               break;
            case 2:
               Alarm.show("只有战胜谱尼的第一封印：虚无，才能挑战第二封印：元素的化身。");
               break;
            case 3:
               Alarm.show("只有战胜谱尼的第二封印：元素，才能挑战第三封印：能量的化身。");
               break;
            case 4:
               Alarm.show("只有战胜谱尼的第三封印：能量，才能挑战第四封印：生命的化身。");
               break;
            case 5:
               Alarm.show("只有战胜谱尼的第四封印：生命，才能挑战第五封印：轮回的化身。");
               break;
            case 6:
               Alarm.show("只有战胜谱尼的第五封印：轮回，才能挑战第六封印：永恒的化身。");
               break;
            case 7:
               Alarm.show("只有战胜谱尼的第六封印：永恒，才能挑战第七封印：圣洁的化身。");
         }
      }
      
      private function onError11028Handler(param1:RobotEvent) : void
      {
         switch(doorindex)
         {
            case 1:
               Alarm.show("谱尼的第一封印：虚无 已进入暂时封闭状态，明天将会再度打开。");
               break;
            case 2:
               Alarm.show("谱尼的第二封印：元素 已进入暂时封闭状态，明天将会再度打开。");
               break;
            case 3:
               Alarm.show("谱尼的第三封印：能量 已进入暂时封闭状态，明天将会再度打开。");
               break;
            case 4:
               Alarm.show("谱尼的第四封印：生命 已进入暂时封闭状态，明天将会再度打开。");
               break;
            case 5:
               Alarm.show("谱尼的第五封印：轮回 已进入暂时封闭状态，明天将会再度打开。");
               break;
            case 6:
               Alarm.show("谱尼的第六封印：永恒 已进入暂时封闭状态，明天将会再度打开。");
               break;
            case 7:
               Alarm.show("谱尼的第七封印：圣洁 已进入暂时封闭状态，明天将会再度打开。");
         }
      }
      
      public function onCachetMc0Handler(param1:MovieClip) : void
      {
         this.currentMC = null;
         this.currentMC = param1;
         var _loc2_:uint = uint(uint(this.currentMC.name.split("_")[1]) + 1);
         doorindex = _loc2_;
         switch(param1.name)
         {
            case "cachetMc_0":
               Alert.show("谱尼的第一封印：虚无 已经开启，只有战胜谱尼内心的封印化身才能解除这个封印，你准备好去挑战了吗？",this.sureHandler);
               break;
            case "cachetMc_1":
               Alert.show("谱尼的第二封印：元素 已经开启，只有战胜谱尼内心的封印化身才能解除这个封印，你准备好去挑战了吗？",this.sureHandler);
               break;
            case "cachetMc_2":
               Alert.show("谱尼的第三封印：能量 已经开启，只有战胜谱尼内心的封印化身才能解除这个封印，你准备好去挑战了吗？",this.sureHandler);
               break;
            case "cachetMc_3":
               Alert.show("谱尼的第四封印：生命 已经开启，只有战胜谱尼内心的封印化身才能解除这个封印，你准备好去挑战了吗？",this.sureHandler);
               break;
            case "cachetMc_4":
               Alert.show("谱尼的第五封印：轮回 已经开启，只有战胜谱尼内心的封印化身才能解除这个封印，你准备好去挑战了吗？",this.sureHandler);
               break;
            case "cachetMc_5":
               Alert.show("谱尼的第六封印：永恒 已经开启，只有战胜谱尼内心的封印化身才能解除这个封印，你准备好去挑战了吗？",this.sureHandler);
               break;
            case "cachetMc_6":
               Alert.show("谱尼的第七封印：圣洁 已经开启，只有战胜谱尼内心的封印化身才能解除这个封印，你准备好去挑战了吗？",this.sureHandler);
         }
      }
      
      private function sureHandler1() : void
      {
         if(MainManager.actorInfo.maxPuniLv >= 7)
         {
            doorindex = 8;
            SocketConnection.addCmdListener(CommandID.MIBAO_FIGHT,this.onFSucHandler);
            FightDispatcher.addEventListener(PetFightEvent.FIGHT_CLOSE,this.onCloseFight);
            if(MapManager.currentMap.id == 10032)
            {
               FightManager.fightNoMapBoss("谱尼的真身",6728 + doorindex - 1,true);
            }
         }
      }
      
      private function sureHandler() : void
      {
         var t2:uint = 0;
         var bossname:String = String(this.currentMC.des).split("-")[1] + "的化身";
         this.currentMC.gotoAndStop(2);
         this.currentMC.mouseChildren = false;
         this.currentMC.mouseEnabled = false;
         t2 = setTimeout(function():void
         {
            clearTimeout(t2);
            if(currentMC == null)
            {
               return;
            }
            currentMC.gotoAndStop(1);
            currentMC.mouseChildren = true;
            currentMC.mouseEnabled = true;
         },500);
         this._type = 0;
         SocketConnection.addCmdListener(CommandID.MIBAO_FIGHT,this.onFSucHandler);
         FightDispatcher.addEventListener(PetFightEvent.FIGHT_CLOSE,this.onCloseFight);
         if(MapManager.currentMap.id == 10032)
         {
            FightManager.fightNoMapBoss(bossname,6728 + doorindex - 1,true);
         }
      }
      
      private function onBagHandler(param1:MouseEvent) : void
      {
         FightPetBagController.show();
      }
      
      private function onMhtClickHandler(param1:MouseEvent) : void
      {
         var t3:uint = 0;
         var e:MouseEvent = param1;
         if(MainManager.actorInfo.maxPuniLv >= 7)
         {
            depthLevel["hh"].gotoAndStop(3);
            Alert.show("谱尼的防护屏障已经消失，现在可以挑战谱尼的真身，你准备好去挑战了吗？",this.sureHandler1);
         }
         else
         {
            depthLevel["mhtHitMc"].removeEventListener(MouseEvent.CLICK,this.onMhtClickHandler);
            t3 = setTimeout(function():void
            {
               clearTimeout(t3);
               depthLevel["mhtHitMc"].addEventListener(MouseEvent.CLICK,onMhtClickHandler);
            },1500);
            this._type = 1;
            SocketConnection.addCmdListener(CommandID.MIBAO_FIGHT,this.onFSucHandler);
            if(MapManager.currentMap.id == 10032)
            {
               FightManager.fightNoMapBoss("谱尼",6736);
            }
         }
      }
      
      private function onCloseFight(param1:PetFightEvent) : void
      {
         var _loc2_:FightOverInfo = null;
         FightDispatcher.removeEventListener(PetFightEvent.FIGHT_CLOSE,this.onCloseFight);
         if(this._type == 0)
         {
            _loc2_ = param1.dataObj["data"];
            if(_loc2_.winnerID == MainManager.actorID)
            {
               if(doorindex == MainManager.actorInfo.maxPuniLv + 1)
               {
                  if(this.currentMC)
                  {
                     this.currentMC.gotoAndStop(3);
                  }
                  ++MainManager.actorInfo.maxPuniLv;
               }
               switch(MainManager.actorInfo.maxPuniLv)
               {
                  case 1:
                     Alarm.show("谱尼的第一封印：虚无 已经解除，只有将谱尼所有封印内的化身击败才能真正战胜它。");
                     break;
                  case 2:
                     Alarm.show("谱尼的第二封印：元素 已经解除，只有将谱尼所有封印内的化身击败才能真正战胜它。");
                     break;
                  case 3:
                     Alarm.show("谱尼的第三封印：能量 已经解除，只有将谱尼所有封印内的化身击败才能真正战胜它。");
                     break;
                  case 4:
                     Alarm.show("谱尼的第四封印：生命 已经解除，只有将谱尼所有封印内的化身击败才能真正战胜它。");
                     break;
                  case 5:
                     Alarm.show("谱尼的第五封印：轮回 已经解除，只有将谱尼所有封印内的化身击败才能真正战胜它。");
                     break;
                  case 6:
                     Alarm.show("谱尼的第六封印：永恒 已经解除，只有将谱尼所有封印内的化身击败才能真正战胜它。");
                     break;
                  case 7:
                     Alarm.show("谱尼的第七封印：圣洁 已经解除，谱尼进入了心灵封闭状态。");
                     FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,this.petFightOver);
                     break;
                  case 8:
                     FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,this.petFightOver);
               }
            }
         }
      }
      
      private function petFightOver(param1:PetFightEvent) : void
      {
         var t4:uint = 0;
         var e:PetFightEvent = param1;
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.petFightOver);
         t4 = setTimeout(function():void
         {
            clearTimeout(t4);
            conLevel["aiMc"].gotoAndPlay(2);
         },2000);
      }
      
      private function onFSucHandler(param1:SocketEvent) : void
      {
         SocketConnection.removeCmdListener(CommandID.MIBAO_FIGHT,this.onFSucHandler);
         if(this._type == 1)
         {
            TasksManager.setTaskStatus(462,TasksManager.COMPLETE);
         }
         else
         {
            MainManager.actorInfo.dailyResArr[40 + doorindex - 1] = true;
         }
      }
      
      override public function destroy() : void
      {
         EventManager.removeEventListener(RobotEvent.ERROR_11027,this.onError11027Handler);
         EventManager.removeEventListener(RobotEvent.ERROR_11028,this.onError11028Handler);
         SocketConnection.removeCmdListener(CommandID.MIBAO_FIGHT,this.onFSucHandler);
         ToolTipManager.remove(conLevel["bagMc"]);
         ToolTipManager.remove(depthLevel["mhtHitMc"]);
         ToolTipManager.remove(conLevel["door_0"]);
         depthLevel["mhtHitMc"].removeEventListener(MouseEvent.CLICK,this.onMhtClickHandler);
         ToolBarController.panel.show();
         LevelManager.iconLevel.visible = true;
      }
      
      public function onLeaveHandler() : void
      {
         MapManager.changeMap(1153);
         FightPetBagController.destroy();
      }
   }
}

