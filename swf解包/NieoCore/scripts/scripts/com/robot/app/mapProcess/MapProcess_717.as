package com.robot.app.mapProcess
{
   import com.robot.app.spt.FightBossController;
   import com.robot.app.task.taskscollection.Task972;
   import com.robot.app.task.taskscollection.Task983;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.info.fightInfo.attack.FightOverInfo;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import org.taomee.manager.EventManager;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcess_717 extends BaseMapProcess
   {
      
      public function MapProcess_717()
      {
         super();
      }
      
      override protected function init() : void
      {
         StatManager.sendStat2014("瑞尔斯超进化","进入435场景",StatManager.RUN_ACT);
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         this.initSpt();
         Task983.initForMap717(this);
         if(TasksManager.getTaskStatus(983) == TasksManager.ALR_ACCEPT)
         {
            TasksManager.getProStatusList(983,function(param1:Array):void
            {
               if(Boolean(param1[0]) && !param1[1])
               {
                  DisplayUtil.removeForParent(conLevel["task972mc"]);
               }
               else
               {
                  initTask972();
               }
            });
         }
         else
         {
            this.initTask972();
         }
      }
      
      private function initTask972() : void
      {
         Task972.initForMap(this);
      }
      
      private function initSpt() : void
      {
         this.spt.buttonMode = true;
         this.spt.addEventListener(MouseEvent.CLICK,this.showBoss);
      }
      
      private function showBoss(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         MainManager.actorModel.moveAndAction(new Point(585,300),function():void
         {
            AnimateManager.playMcAnimate(spt,1,"mc",function():void
            {
               NpcDialog.show(NPC.KALUNNI,["吵醒我的代价将会是死路一条，我答应过帕罗狄亚大人，不会让任何人活着离开这里，不想死的赶紧逃命去吧！！"],["我就是来挑战你的！","让我先准备一下！"],[function():void
               {
                  FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,onAlarmClickHandler);
                  EventManager.removeEventListener(RobotEvent.NO_PET_CAN_FIGHT,onFightError);
                  FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,onAlarmClickHandler);
                  EventManager.addEventListener(RobotEvent.NO_PET_CAN_FIGHT,onFightError);
                  FightBossController.fightBoss("卡伦尼");
               },function():void
               {
                  AnimateManager.playMcAnimate(spt,2,"mc",function():void
                  {
                     spt.gotoAndStop(1);
                  });
               }]);
            });
         });
      }
      
      private function onAlarmClickHandler(param1:PetFightEvent) : void
      {
         var e:PetFightEvent = param1;
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.onAlarmClickHandler);
         EventManager.removeEventListener(RobotEvent.NO_PET_CAN_FIGHT,this.onFightError);
         if((e.dataObj as FightOverInfo).winnerID == MainManager.actorID)
         {
            NpcDialog.show(NPC.KALUNNI,["小子，你的实力已经完全超越了我，看来帕罗狄亚大人这次遇到对手了！"],["你知道就好！我是不会放过它的！"],[function():void
            {
            }]);
         }
         else
         {
            MapManager.currentMap.controlLevel["sptBoss"].gotoAndStop(2);
            NpcDialog.show(NPC.KALUNNI,["小子，你难道没有听清楚我说的话吗？我是不会让任何人活着离开这里的，知趣的话快离开这里！"],["别高兴的太早，下次我一定会战胜你的！"],[function():void
            {
               AnimateManager.playMcAnimate(MapManager.currentMap.controlLevel["sptBoss"],2,"mc",function():void
               {
               });
            }]);
         }
      }
      
      private function onFightError(param1:RobotEvent) : void
      {
         var e:RobotEvent = param1;
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.onAlarmClickHandler);
         EventManager.removeEventListener(RobotEvent.NO_PET_CAN_FIGHT,this.onFightError);
         AnimateManager.playMcAnimate(this.spt,2,"mc",function():void
         {
            spt.gotoAndStop(1);
         });
      }
      
      private function get spt() : MovieClip
      {
         return conLevel["sptBoss"];
      }
      
      override public function destroy() : void
      {
         this.spt.removeEventListener(MouseEvent.CLICK,this.showBoss);
         Task972.destroy();
         Task983.destroy();
         super.destroy();
      }
   }
}

