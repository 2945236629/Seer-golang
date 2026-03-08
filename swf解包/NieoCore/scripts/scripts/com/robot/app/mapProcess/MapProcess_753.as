package com.robot.app.mapProcess
{
   import com.robot.app.group.manager.GroupFightInviteManager;
   import com.robot.app.task.taskscollection.Task1156;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.group.fightInfo.fightOver.GroupFightOverInfo;
   import com.robot.core.group.manager.GroupManager;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.TasksManager;
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
   
   public class MapProcess_753 extends BaseMapProcess
   {
      
      private var _leaderID:uint;
      
      private var _memberArr:Array;
      
      private var _prevPositionArr:Array;
      
      private var _prevDirectionArr:Array;
      
      public function MapProcess_753()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86048997);
         SocketConnection.send(1022,86053224);
         SocketConnection.send(1022,86053227);
         this.initBoss();
         Task1156.initTaskFor753(this);
      }
      
      private function initBoss() : void
      {
         if(TasksManager.getTaskStatus(1156) == TasksManager.ALR_ACCEPT)
         {
            TasksManager.getProStatusList(1156,function(param1:Array):void
            {
               if(param1[1])
               {
                  bossMC.visible = false;
               }
            });
         }
         ToolTipManager.add(this.bossMC,"卡罗特利");
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
            NpcDialog.show(NPC.KALUOTELI,["我是火鹿王-里奥杰斯最得力的助手，也是火焰山脊最勇敢的战士，你敢挑战我吗？"],["我想挑战你（二人以上组队挑战）","我还是再考虑一下吧！"],[function():void
            {
               certification();
            },function():void
            {
               AnimateManager.playMcAnimate(bossMC,4,"mc",function():void
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
            AnimateManager.playMcAnimate(this.bossMC,3,"mc",function():void
            {
               FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,onFightOver);
               GroupFightInviteManager.fightWithBoss("卡罗特利");
            });
         }
         else
         {
            NpcDialog.show(NPC.KALUOTELI,["就你一个人也想挑战我！哼哼，太可笑了！你还是先去招募一些你的队友来吧！否则你一定不是我的对手！"],["我这就去召集伙伴！"],[function():void
            {
               AnimateManager.playMcAnimate(bossMC,4,"mc",function():void
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
         GroupFightInviteManager.fightWithBoss("卡罗特利");
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
               NpcDialog.show(NPC.KALUOTELI,["没想到伙伴的力量如此强大，我甘拜下风，不过下次就没这么走运了！"],["知道我们的厉害吧！"],[function():void
               {
               }]);
            }
            else
            {
               NpcDialog.show(NPC.KALUOTELI,["你们的实力太弱了，哼哼，好好回家练练！或者招募一些有实力的帮手来！否则你一定不是我的对手！"],["我这就去召集伙伴！"]);
            }
         }
         AnimateManager.playMcAnimate(this.bossMC,4,"mc",function():void
         {
            bossMC.gotoAndStop(1);
            bossMC.buttonMode = true;
         });
      }
      
      private function get bossMC() : MovieClip
      {
         if(conLevel["sptBoss"] != null)
         {
            return conLevel["sptBoss"];
         }
         return null;
      }
      
      override public function destroy() : void
      {
         ToolTipManager.remove(this.bossMC);
         this.bossMC.removeEventListener(MouseEvent.CLICK,this.onBossClick);
         Task1156.destroy();
      }
   }
}

