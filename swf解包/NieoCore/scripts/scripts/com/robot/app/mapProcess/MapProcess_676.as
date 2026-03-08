package com.robot.app.mapProcess
{
   import com.robot.app.spt.*;
   import com.robot.app.task.taskscollection.*;
   import com.robot.core.animate.*;
   import com.robot.core.dispatcher.*;
   import com.robot.core.event.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.*;
   import flash.events.*;
   import org.taomee.manager.*;
   
   public class MapProcess_676 extends BaseMapProcess
   {
      
      public function MapProcess_676()
      {
         super();
      }
      
      override protected function init() : void
      {
         var map:BaseMapProcess = null;
         map = null;
         map = this;
         conLevel["fire0"].visible = false;
         conLevel["fire1"].visible = false;
         conLevel["fire2"].visible = false;
         conLevel["pet0"].visible = false;
         conLevel["pet1"].visible = false;
         conLevel["pet2"].visible = false;
         conLevel["hand0"].visible = false;
         conLevel["hand1"].visible = false;
         conLevel["hand2"].visible = false;
         conLevel["mier"].visible = false;
         conLevel["task741_1"].visible = false;
         conLevel["task746"].visible = false;
         conLevel["mierClick"].visible = false;
         Task753.initTaskForMap676(this);
         TasksManager.getProStatusList(753,function(param1:Array):void
         {
            var a:Array = param1;
            if(Boolean(a[0]) && Boolean(a[1]) && Boolean(a[2]) && Boolean(a[3]) && !a[4])
            {
               return;
            }
            Task746.initTaskFor676(map);
            TasksManager.getProStatusList(746,function(param1:Array):void
            {
               if((!param1[0] || param1[0] && !param1[1]) && TasksManager.getTaskStatus(746) != TasksManager.COMPLETE)
               {
                  return;
               }
               Task741.initTaskFor676(map);
               addSpt();
            });
         });
      }
      
      private function addSpt() : void
      {
         depthLevel["spt"].buttonMode = true;
         depthLevel["spt"].gotoAndStop(5);
         depthLevel["spt"].addEventListener(MouseEvent.CLICK,this.onClickSpt);
      }
      
      private function onClickSpt(param1:Event) : void
      {
         var event:Event = param1;
         depthLevel["spt"].removeEventListener(MouseEvent.CLICK,this.onClickSpt);
         AnimateManager.playMcAnimate(depthLevel["spt"],2,"mc2",function():void
         {
            ToolTipManager.add(depthLevel["spt"],"古尔扎迪");
            depthLevel["spt"].buttonMode = true;
            depthLevel["spt"].addEventListener(MouseEvent.CLICK,onClickBoss);
         });
      }
      
      private function onClickBoss(param1:Event) : void
      {
         var event:Event = param1;
         NpcDialog.show(NPC.GUERZHADI,["哼哼！不知死活的小子，闪一边去，我对你可没什么兴趣！我只知道这个机会等了上万年！如果不是邪恶异能王的觉醒，我想我还在地下长眠呢！呵哈哈哈…."],["古尔扎迪，我这就收拾你！！"],[function():void
         {
            Task741.isFight = true;
            FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,onCompleteFight);
            FightBossController.fightBoss("古尔扎迪");
         }]);
      }
      
      private function onCompleteFight(param1:PetFightEvent) : void
      {
         var event:PetFightEvent = param1;
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.onCompleteFight);
         Task741.isFight = false;
         if(event.dataObj.winnerID != MainManager.actorID)
         {
            depthLevel["spt"].gotoAndStop(3);
            NpcDialog.show(NPC.GUERZHADI,["哼哼！你这是在给我挠痒吗？省省吧！臭小子，想击败我你还嫩了点！黑暗将笼罩整个异能星……….."],["可恶的家伙，我一定会击败你的！"],[function():void
            {
               depthLevel["spt"].removeEventListener(MouseEvent.CLICK,onClickSpt);
               depthLevel["spt"].buttonMode = true;
               depthLevel["spt"].addEventListener(MouseEvent.CLICK,onClickBoss);
            }]);
         }
         else
         {
            depthLevel["spt"].gotoAndStop(5);
            depthLevel["spt"].removeEventListener(MouseEvent.CLICK,this.onClickBoss);
            depthLevel["spt"].buttonMode = true;
            depthLevel["spt"].addEventListener(MouseEvent.CLICK,this.onClickSpt);
         }
      }
      
      override public function destroy() : void
      {
         if(!Task741.isFight)
         {
            FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.onCompleteFight);
         }
         if(Boolean(depthLevel["spt"]) && !Task741.isFight)
         {
            ToolTipManager.remove(depthLevel["spt"]);
            depthLevel["spt"].removeEventListener(MouseEvent.CLICK,this.onClickSpt);
            depthLevel["spt"].removeEventListener(MouseEvent.CLICK,this.onClickBoss);
         }
         Task741.destroy();
         Task746.destroy();
         Task753.destroy();
      }
   }
}

