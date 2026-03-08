package com.robot.app.mapProcess
{
   import com.robot.app.spt.*;
   import com.robot.app.task.taskscollection.*;
   import com.robot.app.toolBar.*;
   import com.robot.core.*;
   import com.robot.core.animate.*;
   import com.robot.core.dispatcher.*;
   import com.robot.core.event.*;
   import com.robot.core.info.fightInfo.attack.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.*;
   import com.robot.core.npc.*;
   import com.robot.core.ui.alert.*;
   import flash.events.*;
   import flash.utils.*;
   import org.taomee.events.SocketEvent;
   import org.taomee.manager.*;
   import org.taomee.utils.*;
   
   public class MapProcess_686 extends BaseMapProcess
   {
      
      private var _bridgeClickCount:uint = 0;
      
      private var _fruitTimer1:Timer;
      
      private var _fruitTimer2:Timer;
      
      public function MapProcess_686()
      {
         super();
      }
      
      private static function onFinishFight(param1:PetFightEvent) : void
      {
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,onFinishFight);
         var _loc2_:FightOverInfo = param1.dataObj as FightOverInfo;
         if(_loc2_.winnerID != MainManager.actorID)
         {
            NpcDialog.show(NPC.ANYEBINGFU,["哈哈！你也太弱了吧！不过呢？如果你拥有0xff0000火之果0xffffff，可能我还会怕你三分！0xff0000不过火之果很难获得，不信你可以去我周围的冰洞中找找！0xffffff"],["好，我等等再来挑战你！"]);
         }
      }
      
      override protected function init() : void
      {
         var map:BaseMapProcess = null;
         map = null;
         map = this;
         animatorLevel["task_801_3"].visible = false;
         animatorLevel["task_811_6"].visible = false;
         this._fruitTimer1 = new Timer(2000);
         this._fruitTimer1.addEventListener(TimerEvent.TIMER,this.onTimer1);
         this._fruitTimer2 = new Timer(2000);
         this._fruitTimer2.addEventListener(TimerEvent.TIMER,this.onTimer2);
         Task811.initTaskForMap686(this);
         if(TasksManager.getTaskStatus(816) == TasksManager.ALR_ACCEPT)
         {
            TasksManager.getProStatusList(811,function(param1:Array):void
            {
               if(Boolean(param1[0]) && Boolean(param1[1]) && Boolean(param1[2]) && Boolean(param1[3]) && Boolean(param1[4]) && !param1[5])
               {
                  return;
               }
               Task801.initTaskForMap686(map);
            });
         }
         else
         {
            Task801.initTaskForMap686(map);
         }
         this.initBridge();
         this.initSptAnyebinghu();
         this.initFireFruit();
      }
      
      private function initFireFruit() : void
      {
         ToolTipManager.add(conLevel["fireFruit"],"火之果");
         conLevel["fireFruit"].buttonMode = true;
         conLevel["fireFruit"].addEventListener(MouseEvent.CLICK,this.onFireFruitClick);
      }
      
      private function onFireFruitClick(param1:MouseEvent) : void
      {
         conLevel["fireFruit"].buttonMode = false;
         conLevel["fireFruit"].removeEventListener(MouseEvent.CLICK,this.onFireFruitClick);
         SocketConnection.send(CommandID.GET_FIREFRUIT);
         SocketConnection.addCmdListener(CommandID.GET_FIREFRUIT,this.onFruitHandler);
      }
      
      private function onFruitHandler(param1:SocketEvent) : void
      {
         SocketConnection.removeCmdListener(CommandID.GET_FIREFRUIT,this.onFruitHandler);
         var _loc2_:ByteArray = param1.data as ByteArray;
         var _loc3_:uint = _loc2_.readUnsignedInt();
         if(_loc3_ == 300451)
         {
            conLevel["fireFruit"].gotoAndStop(2);
            this._fruitTimer1.start();
         }
         else if(_loc3_ == 0)
         {
            conLevel["fireFruit"].gotoAndStop(3);
            this._fruitTimer2.start();
         }
      }
      
      private function onTimer1(param1:TimerEvent) : void
      {
         this.alarmGetFruit();
         this._fruitTimer1.reset();
      }
      
      private function onTimer2(param1:TimerEvent) : void
      {
         conLevel["fireFruit"].gotoAndStop(1);
         conLevel["fireFruit"].buttonMode = true;
         conLevel["fireFruit"].addEventListener(MouseEvent.CLICK,this.onFireFruitClick);
         this._fruitTimer2.reset();
      }
      
      private function alarmGetFruit() : void
      {
         Alarm.show("恭喜获得一个火之果！",function():void
         {
            conLevel["fireFruit"].gotoAndStop(1);
            conLevel["fireFruit"].buttonMode = true;
            conLevel["fireFruit"].addEventListener(MouseEvent.CLICK,onFireFruitClick);
         });
      }
      
      private function initSptAnyebinghu() : void
      {
         ToolTipManager.add(conLevel["sptAnyebinghu"],"暗夜冰狐");
         conLevel["sptAnyebinghu"].buttonMode = true;
         conLevel["sptAnyebinghu"].addEventListener(MouseEvent.CLICK,this.onSptClick);
      }
      
      private function onSptClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         AnimateManager.playMcAnimate(conLevel["sptAnyebinghu"],2,"mc",function():void
         {
            NpcDialog.show(NPC.ANYEBINGFU,["快看，那边可是四大神兽的石像哦！我也想早日成为神兽级的精灵！那样火狐就一定会以为为傲的！嘿嘿！"],["我要向你挑战！","我随便说说的！"],[function():void
            {
               SocketConnection.send(CommandID.ANYEBINHU_LEVEL);
               SocketConnection.addCmdListener(CommandID.ANYEBINHU_LEVEL,onLevelHandler);
               FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,onFinishFight);
            }]);
         });
      }
      
      private function onLevelHandler(param1:SocketEvent) : void
      {
         SocketConnection.removeCmdListener(CommandID.ANYEBINHU_LEVEL,this.onLevelHandler);
         var _loc2_:ByteArray = param1.data as ByteArray;
         var _loc3_:uint = _loc2_.readUnsignedInt();
         if(_loc3_ == 0)
         {
            FightBossController.fightBoss("暗夜冰狐");
         }
         else
         {
            FightBossController.fightBoss("暗夜冰狐",1);
         }
      }
      
      private function initBridge() : void
      {
         ToolTipManager.add(conLevel["bridge"],"吊桥木板");
         conLevel["bridge"].buttonMode = true;
         conLevel["bridge"].addEventListener(MouseEvent.CLICK,this.onBridgeClick);
      }
      
      private function onBridgeClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         ++this._bridgeClickCount;
         AnimateManager.playMcAnimate(conLevel["bridge"],this._bridgeClickCount,"mc",function():void
         {
            if(_bridgeClickCount == 2)
            {
               conLevel["bridge"].buttonMode = false;
               conLevel["bridge"].removeEventListener(MouseEvent.CLICK,onBridgeClick);
               DisplayUtil.removeForParent(typeLevel["barrier"]);
               MapManager.currentMap.makeMapArray();
               ToolTipManager.remove(conLevel["bridge"]);
               if(TasksManager.getTaskStatus(801) == TasksManager.ALR_ACCEPT)
               {
                  TasksManager.getProStatusList(801,function(param1:Array):void
                  {
                     if(Boolean(param1[0]) && Boolean(param1[1]) && Boolean(param1[2]) && !param1[3])
                     {
                        Task801.onBridge();
                     }
                  });
               }
            }
         });
      }
      
      override public function destroy() : void
      {
         Task801.destroy();
         Task811.destroy();
         if(Boolean(conLevel["bridge"]))
         {
            ToolTipManager.remove(conLevel["bridge"]);
            conLevel["bridge"].removeEventListener(MouseEvent.CLICK,this.onBridgeClick);
         }
         this._bridgeClickCount = 0;
         ToolBarController.showOrHideAllUser(true);
      }
   }
}

