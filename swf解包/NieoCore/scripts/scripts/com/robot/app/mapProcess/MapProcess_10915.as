package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.CommandID;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.info.fightInfo.attack.FightOverInfo;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import com.robot.core.ui.alert.Alarm2;
   import com.robot.core.ui.alert.Alert;
   import com.robot.core.utils.BitUtils;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import org.taomee.events.SocketEvent;
   import org.taomee.manager.ResourceManager;
   import org.taomee.manager.ToolTipManager;
   
   public class MapProcess_10915 extends BaseMapProcess
   {
      
      private static var status:Array = [0,0,0];
      
      private var failPanel:MovieClip;
      
      public function MapProcess_10915()
      {
         super();
      }
      
      override public function destroy() : void
      {
         if(this.failPanel)
         {
            SimpleButton(this.failPanel["btn_0"]).addEventListener(MouseEvent.CLICK,this.onClickRevole);
            SimpleButton(this.failPanel["btn_1"]).addEventListener(MouseEvent.CLICK,this.onClickCancel);
            this.failPanel = null;
         }
         SimpleButton(btnLevel["btnBoss_0"]).removeEventListener(MouseEvent.CLICK,this.onClickGuard0);
         SimpleButton(btnLevel["btnBoss_1"]).removeEventListener(MouseEvent.CLICK,this.onClickGuard1);
         SimpleButton(btnLevel["btnBoss"]).removeEventListener(MouseEvent.CLICK,this.onClickBoss);
         SimpleButton(btnLevel["btnExit"]).removeEventListener(MouseEvent.CLICK,this.onClickExit);
         KTool.showMapAllPlayerAndMonster();
         ToolBarController.panel.show();
         LevelManager.iconLevel.visible = true;
         ToolTipManager.remove(btnLevel["btnExit"]);
         super.destroy();
      }
      
      override protected function init() : void
      {
         super.init();
         ToolBarController.panel.hide();
         ToolBarController.showOrHideAllUser(false);
         LevelManager.iconLevel.visible = false;
         SimpleButton(btnLevel["btnBoss_0"]).addEventListener(MouseEvent.CLICK,this.onClickGuard0);
         SimpleButton(btnLevel["btnBoss_1"]).addEventListener(MouseEvent.CLICK,this.onClickGuard1);
         SimpleButton(btnLevel["btnBoss"]).addEventListener(MouseEvent.CLICK,this.onClickBoss);
         SimpleButton(btnLevel["btnExit"]).addEventListener(MouseEvent.CLICK,this.onClickExit);
         ToolTipManager.add(btnLevel["btnExit"],"结束挑战");
         this.updateStatus();
      }
      
      protected function onClickExit(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         Alert.show("你确定要直接结束本次玄武挑战吗？",function():void
         {
            SocketConnection.sendWithCallback(47212,function(param1:SocketEvent):void
            {
               MapManager.changeMap(1093);
            },4,0);
         });
      }
      
      private function updateStatus() : void
      {
         var num:int = 0;
         var arr:Array = [537,538,539,541];
         var paramArr:ByteArray = new ByteArray();
         for each(num in arr)
         {
            paramArr.writeInt(num);
         }
         SocketConnection.sendByQueue(CommandID.SAROD_PROVE_PLAYER_INFO,[arr.length,paramArr],function(param1:SocketEvent):void
         {
            var _loc2_:ByteArray = param1.data as ByteArray;
            _loc2_.position = 0;
            var _loc3_:int = int(_loc2_.readUnsignedInt());
            var _loc4_:Array = new Array();
            var _loc5_:int = 0;
            while(_loc5_ < _loc3_)
            {
               _loc4_.push(_loc2_.readUnsignedInt());
               _loc5_++;
            }
            status = _loc4_;
            if(BitUtils.getBit(status[0],21) > 0)
            {
               SimpleButton(btnLevel["btnBoss_0"]).visible = false;
            }
            if(BitUtils.getBit(status[0],20) > 0)
            {
               SimpleButton(btnLevel["btnBoss_1"]).visible = false;
            }
         });
      }
      
      protected function onClickGuard1(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(NPC.JING_JIA_BAO_YAN,["欢迎你，勇士。我们是北冥•玄武大人的守护，击败我们，你就可以最终挑战北冥•玄武大人了！"],["我要挑战你！","让我再准备准备。"],[function():void
         {
            fight("晶甲暴岩",4195);
         }]);
      }
      
      protected function onClickGuard0(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(NPC.MO_JIA_BA_XIA,["欢迎你，勇士。我们是北冥•玄武大人的守护，击败我们，你就可以最终挑战北冥•玄武大人了！"],["我要挑战你！","让我再准备准备。"],[function():void
         {
            fight("墨甲霸下",4196);
         }]);
      }
      
      protected function onClickBoss(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         if(BitUtils.getBit(status[0],20) > 0 && BitUtils.getBit(status[0],21) > 0)
         {
            NpcDialog.show(NPC.BEI_MING_XUAN_WU,["勇士，你能来到我的面前，证明了你非凡的实力。现在，只要战胜我，你就可以完成最终目标，得到我的承认了！"],["我要挑战你！","让我再准备准备。"],[function():void
            {
               fight("北冥•玄武",4197);
            }]);
         }
         else
         {
            NpcDialog.show(NPC.BEI_MING_XUAN_WU,["不要着急，我的勇士。只有击败我的全部守卫，你才能开始挑战我哦！"],null);
         }
      }
      
      private function fight(param1:String, param2:int) : void
      {
         var count:int = 0;
         var onFight:Function = null;
         var name:String = param1;
         var boss:int = param2;
         onFight = function(param1:*):void
         {
            var e:* = param1;
            FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,onFight);
            if((e.dataObj as FightOverInfo).winnerID != MainManager.actorID && count == 0)
            {
               count = 1;
               if(status[1] < 5)
               {
                  StatManager.sendStat2014("0703玄武超进化","打开原地复活面板",StatManager.RUN_ACT_2015);
                  showRevole();
               }
               else
               {
                  Alarm2.show("本次玄武挑战中，你已经用完了所有的复活次数（共5次），挑战失败！",function():void
                  {
                     SocketConnection.sendWithCallback(47212,function(param1:SocketEvent):void
                     {
                        MapManager.changeMap(1093);
                     },4,0);
                  });
               }
            }
            else if(boss == 4197)
            {
               MapManager.changeMap(1093);
            }
         };
         if(BitUtils.getBit(status[3],0) > 0)
         {
            this.showRevole();
            return;
         }
         count = 0;
         FightManager.fightNoMapBoss(name,boss);
         FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,onFight);
      }
      
      private function showRevole() : void
      {
         if(this.failPanel)
         {
            LevelManager.fightLevel.addChild(this.failPanel);
         }
         else
         {
            this.failPanel = new MovieClip();
            ResourceManager.getResource(ClientConfig.getAppRes("xuanwufightfail"),function(param1:MovieClip):void
            {
               failPanel = param1;
               SimpleButton(failPanel["btn_0"]).addEventListener(MouseEvent.CLICK,onClickRevole);
               SimpleButton(failPanel["btn_1"]).addEventListener(MouseEvent.CLICK,onClickCancel);
               LevelManager.fightLevel.addChild(failPanel);
            });
         }
      }
      
      private function onClickRevole(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         if(Boolean(this.failPanel) && Boolean(this.failPanel.parent))
         {
            this.failPanel.parent.removeChild(this.failPanel);
         }
         KTool.buyProductByCallback(243787,1,function():void
         {
            SocketConnection.sendWithCallback(47212,function(param1:SocketEvent):void
            {
               ++status[1];
               status[3] = 0;
            },5,0);
         });
      }
      
      private function onClickCancel(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         if(Boolean(this.failPanel) && Boolean(this.failPanel.parent))
         {
            this.failPanel.parent.removeChild(this.failPanel);
         }
         Alert.show("你确定要放弃复活机会吗？放弃后本次玄武挑战将直接结束！",function():void
         {
            SocketConnection.sendWithCallback(47212,function(param1:SocketEvent):void
            {
               MapManager.changeMap(1093);
            },4,0);
         },this.showRevole);
      }
   }
}

