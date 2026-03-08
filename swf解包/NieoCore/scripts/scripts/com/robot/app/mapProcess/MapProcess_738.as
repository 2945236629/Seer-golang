package com.robot.app.mapProcess
{
   import com.robot.app.group.manager.GroupFightInviteManager;
   import com.robot.app.task.taskscollection.Task1096;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.group.fightInfo.fightOver.GroupFightOverInfo;
   import com.robot.core.group.manager.GroupManager;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.UserManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.mode.BasePeoleModel;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import org.taomee.manager.ToolTipManager;
   
   public class MapProcess_738 extends BaseMapProcess
   {
      
      private var _leaderID:uint;
      
      private var _memberArr:Array;
      
      private var _prevPositionArr:Array;
      
      private var _prevDirectionArr:Array;
      
      private var _readyNum:uint;
      
      public function MapProcess_738()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86053218);
         SocketConnection.send(1022,86053220);
         this.initBoss();
         Task1096.initTaskForMap738(this);
      }
      
      private function initBoss() : void
      {
         ToolTipManager.add(this.bossMC,"克伦曼尔");
         this.bossMC.gotoAndStop(1);
         this.bossMC.buttonMode = true;
         this.bossMC.addEventListener(MouseEvent.CLICK,this.onBossClick);
      }
      
      private function onBossClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         this.bossMC.buttonMode = false;
         AnimateManager.playMcAnimate(this.bossMC,2,"mc",function():void
         {
            NpcDialog.show(NPC.KELUNMANER,["哼哼，闯入幻影迷阵的人都不会有好结果的！想在这里想战胜我可谓是难上加难，不信你可以站上擂台试试！"],["我想挑战你（二人以上组队挑战）","还是下次再说吧！"],[function():void
            {
               certification();
            },function():void
            {
               AnimateManager.playMcAnimate(bossMC,3,"mc",function():void
               {
                  bossMC.gotoAndStop(1);
                  bossMC.buttonMode = true;
               });
            }]);
         });
      }
      
      private function certification() : void
      {
         if(GroupManager.isInGroup && MainManager.actorInfo.groupInfo && MainManager.actorInfo.groupInfo.memberList.length > 1)
         {
            this.animateForwardControl();
         }
         else
         {
            NpcDialog.show(NPC.KELUNMANER,["仅靠你一个人的力量是无法与我抗衡的，快去找些帮手吧！否则你会输的很惨！"],["可恶，你给我等着！"],[function():void
            {
               AnimateManager.playMcAnimate(bossMC,3,"mc",function():void
               {
                  bossMC.gotoAndStop(1);
                  bossMC.buttonMode = true;
               });
            }]);
         }
      }
      
      private function animateForwardControl() : void
      {
         this._leaderID = MainManager.actorInfo.groupInfo.leaderID;
         this._memberArr = MainManager.actorInfo.groupInfo.memberList;
         this._prevPositionArr = new Array(this._memberArr.length + 1);
         this._prevDirectionArr = new Array(this._memberArr.length + 1);
         var _loc1_:BasePeoleModel = UserManager.getUserModel(this._leaderID);
         this._prevPositionArr[0] = _loc1_.info.pos;
         this._prevDirectionArr[0] = _loc1_.direction;
         _loc1_.walkAction(new Point(287,464));
         LevelManager.closeMouseEvent();
         _loc1_.addEventListener(RobotEvent.WALK_END,this.walkForwardEndHandler);
      }
      
      private function walkForwardEndHandler(param1:RobotEvent) : void
      {
         param1.currentTarget.removeEventListener(RobotEvent.WALK_END,this.walkForwardEndHandler);
         LevelManager.openMouseEvent();
         FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,this.onFightOver);
         GroupFightInviteManager.fightWithBoss("克伦曼尔");
      }
      
      private function onFightOver(param1:PetFightEvent) : void
      {
         var info:GroupFightOverInfo;
         var e:PetFightEvent = param1;
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.onFightOver);
         info = e.dataObj as GroupFightOverInfo;
         if(info.type == 1)
         {
            if(info.winnerID == 1)
            {
               NpcDialog.show(NPC.KELUNMANER,["什么，我竟然会输给你，这不可能...有本事再来挑战我试试！"],["哈哈哈，知道失败的滋味了吧！"],[function():void
               {
               }]);
            }
            else
            {
               NpcDialog.show(NPC.KELUNMANER,["哼哼，早就说过你们是不可能在幻影迷阵战胜我的，回家练练再来挑战我吧！"],["别得意，下次我一定会战胜你的！"]);
            }
         }
         AnimateManager.playMcAnimate(this.bossMC,3,"mc",function():void
         {
            bossMC.gotoAndPlay(1);
            bossMC.buttonMode = true;
         });
         this._readyNum = 0;
      }
      
      private function get bossMC() : MovieClip
      {
         if(depthLevel["sptBoss"] != null)
         {
            return depthLevel["sptBoss"];
         }
         return null;
      }
      
      override public function destroy() : void
      {
         ToolTipManager.remove(this.bossMC);
         this.bossMC.removeEventListener(MouseEvent.CLICK,this.onBossClick);
         Task1096.destroy();
      }
   }
}

