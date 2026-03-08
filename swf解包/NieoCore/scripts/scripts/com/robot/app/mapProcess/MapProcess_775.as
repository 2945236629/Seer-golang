package com.robot.app.mapProcess
{
   import com.robot.app.group.manager.GroupFightInviteManager;
   import com.robot.app.task.taskscollection.Task1220;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.group.fightInfo.fightOver.GroupFightOverInfo;
   import com.robot.core.group.manager.GroupManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.manager.ToolTipManager;
   
   public class MapProcess_775 extends BaseMapProcess
   {
      
      public function MapProcess_775()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86053236);
         SocketConnection.send(1022,86053237);
         Task1220.initTaskFor775(this);
         ToolTipManager.add(this.bossMC,"洛拉菲德");
         this.bossMC.gotoAndStop(1);
         this.bossMC.buttonMode = true;
         this.bossMC.addEventListener(MouseEvent.CLICK,this.onBossClick);
         if(TasksManager.getTaskStatus(1220) == TasksManager.COMPLETE)
         {
            conLevel["tombDoor"].gotoAndStop(2);
         }
         else
         {
            conLevel["tombDoor"].gotoAndStop(1);
         }
      }
      
      private function onBossClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         this.bossMC.buttonMode = false;
         AnimateManager.playMcAnimate(this.bossMC,2,"mc",function():void
         {
            NpcDialog.show(NPC.LUOLAFEIDE,["我们是魔神陵墓的守护者。来者何人！速速离开！"],["我是来挑战你们的（需两人以上组队挑战）！","纯属路过，马上就走！"],[function():void
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
            FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,this.onFightOver);
            GroupFightInviteManager.fightWithBoss("洛拉菲德");
         }
         else
         {
            NpcDialog.show(NPC.LUOLAFEIDE,["去多找一些伙伴再来挑战我吧！"],["我这就去召集伙伴！"],[function():void
            {
               AnimateManager.playMcAnimate(bossMC,3,"mc",function():void
               {
                  bossMC.gotoAndStop(1);
                  bossMC.buttonMode = true;
               });
            }]);
         }
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
               NpcDialog.show(NPC.LUOLAFEIDE,["想不到连我们魔神陵墓的三大守护都不是你的对手！我们承认你的实力！"],null,null,false,function():void
               {
               });
            }
            else
            {
               NpcDialog.show(NPC.LUOLAFEIDE,["连我们都打不过，还敢擅入此地！快点离开吧！"],null,null,false,function():void
               {
               });
            }
         }
         AnimateManager.playMcAnimate(this.bossMC,3,"mc",function():void
         {
            bossMC.gotoAndStop(1);
            bossMC.buttonMode = true;
         });
      }
      
      private function get bossMC() : MovieClip
      {
         if(MapManager.currentMap.controlLevel["sptBoss"])
         {
            return MapManager.currentMap.controlLevel["sptBoss"];
         }
         return null;
      }
      
      override public function destroy() : void
      {
         this.bossMC.removeEventListener(MouseEvent.CLICK,this.onBossClick);
         ToolTipManager.remove(this.bossMC);
         Task1220.destroy();
      }
   }
}

