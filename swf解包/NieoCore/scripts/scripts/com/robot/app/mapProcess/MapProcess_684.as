package com.robot.app.mapProcess
{
   import com.robot.app.spt.*;
   import com.robot.app.task.taskscollection.*;
   import com.robot.app.toolBar.*;
   import com.robot.core.animate.*;
   import com.robot.core.config.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.*;
   import com.robot.core.utils.*;
   import flash.events.*;
   import flash.geom.*;
   import gs.*;
   import org.taomee.manager.*;
   import org.taomee.utils.*;
   
   public class MapProcess_684 extends BaseMapProcess
   {
      
      public function MapProcess_684()
      {
         super();
      }
      
      override protected function init() : void
      {
         var map:BaseMapProcess = null;
         map = null;
         map = this;
         animatorLevel["task_778_2"].visible = false;
         animatorLevel["task_811_4"].visible = false;
         conLevel["task_796_1"].visible = false;
         conLevel["eggTig"].visible = false;
         conLevel["raftTig788"].visible = false;
         conLevel["bubble"].visible = false;
         ToolTipManager.add(conLevel["raftTig"],"小木舟");
         ToolTipManager.add(conLevel["raftTig1"],"小木舟");
         conLevel["vortex"].buttonMode = true;
         conLevel["vortex"].addEventListener(MouseEvent.CLICK,this.onClickVortex);
         this.initBridge();
         this.initRaft();
         Task1143.initFor684(this);
         Task811.initTaskForMap684(this);
         TasksManager.getProStatusList(811,function(param1:Array):void
         {
            if(Boolean(param1[0]) && Boolean(param1[1]) && Boolean(param1[2]) && !param1[3])
            {
               return;
            }
            Task796.initTaskForMap684(map);
            Task788.initTaskForMap684(map);
         });
         this.initSptBoss();
      }
      
      private function onClickVortex(param1:Event) : void
      {
         var e:Event = param1;
         if(Task1143._isPlay)
         {
            AnimateManager.playFullScreenAnimate(ClientConfig.getFullMovie("task_802_2"),function():void
            {
               MapManager.changeMap(687);
            });
         }
         else
         {
            MapManager.changeMap(687);
         }
      }
      
      public function initSptBoss() : void
      {
         ToolTipManager.add(conLevel["sptBoss"],"皮特萨罗的精灵蛋");
         conLevel["sptBoss"].buttonMode = true;
         conLevel["sptBoss"].addEventListener(MouseEvent.CLICK,this.onBossClick);
      }
      
      private function onBossClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         conLevel["bubble"].visible = false;
         AnimateManager.playMcAnimate(conLevel["sptBoss"],2,"flyMC",function():void
         {
            NpcDialog.show(NPC.PITESALUO,["你是谁家的孩子，这么没有教养！你不知道别人的东西不能乱碰吗？你最好离开这里否则我就对你不客气了！"],["我是来挑战你的！"],[function():void
            {
               FightBossController.fightBoss("皮特萨罗");
            }]);
         });
      }
      
      public function initRaft() : void
      {
         if(MapManager.prevMapID == 685)
         {
            this.secondRaft();
         }
         else
         {
            this.firstRaft();
         }
      }
      
      private function firstRaft() : void
      {
         conLevel["raftTig"].buttonMode = true;
         conLevel["raftTig"].addEventListener(MouseEvent.CLICK,this.onRaftClick);
      }
      
      private function onRaftClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         MainManager.actorModel.moveAndAction(new Point(700,350),function():void
         {
            conLevel["raftTig"].buttonMode = false;
            conLevel["raftTig"].removeEventListener(MouseEvent.CLICK,onRaftClick);
            CommonUI.removeYellowArrow(conLevel["raftTig"]);
            LevelManager.closeMouseEvent();
            conLevel["raft_1"].x = 0;
            conLevel["raft_1"].y = 0;
            MainManager.actorModel.addChildAt(conLevel["raft_1"],0);
            TweenLite.to(MainManager.actorModel,3,{
               "x":800,
               "y":250,
               "onComplete":onFinishTween
            });
         });
      }
      
      private function onFinishTween() : void
      {
         LevelManager.openMouseEvent();
         MainManager.actorModel.removeChild(conLevel["raft_1"]);
         conLevel.addChildAt(conLevel["raft_1"],0);
         conLevel["raft_1"].x = 800;
         conLevel["raft_1"].y = 250;
         TweenLite.to(conLevel["raft_1"],3,{
            "x":689,
            "y":357,
            "onComplete":this.secondRaft
         });
      }
      
      private function secondRaft() : void
      {
         conLevel["raftTig1"].buttonMode = true;
         conLevel["raftTig1"].addEventListener(MouseEvent.CLICK,this.onRaft2Click);
      }
      
      private function onRaft2Click(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         MainManager.actorModel.moveAndAction(new Point(750,220),function():void
         {
            conLevel["raftTig1"].buttonMode = false;
            conLevel["raftTig1"].removeEventListener(MouseEvent.CLICK,onRaft2Click);
            LevelManager.closeMouseEvent();
            conLevel["raft_2"].x = 0;
            conLevel["raft_2"].y = 0;
            MainManager.actorModel.addChildAt(conLevel["raft_2"],0);
            TweenLite.to(MainManager.actorModel,3,{
               "x":600,
               "y":300,
               "onComplete":onFinishTween3
            });
         });
      }
      
      private function onFinishTween3() : void
      {
         LevelManager.openMouseEvent();
         MainManager.actorModel.removeChild(conLevel["raft_2"]);
         conLevel.addChildAt(conLevel["raft_2"],0);
         conLevel["raft_2"].x = 600;
         conLevel["raft_2"].y = 300;
         TweenLite.to(conLevel["raft_2"],3,{
            "x":714,
            "y":259,
            "onComplete":this.firstRaft
         });
      }
      
      private function initBridge() : void
      {
         ToolTipManager.add(conLevel["bridge"],"会伸展的枯枝");
         conLevel["bridge"].buttonMode = true;
         conLevel["bridge"].addEventListener(MouseEvent.CLICK,this.onBridgeClick);
      }
      
      private function onBridgeClick(param1:MouseEvent) : void
      {
         var showDialog:Boolean = false;
         showDialog = false;
         var event:MouseEvent = param1;
         conLevel["bridge"].buttonMode = false;
         conLevel["bridge"].removeEventListener(MouseEvent.CLICK,this.onBridgeClick);
         showDialog = false;
         AnimateManager.playMcAnimate(conLevel["bridge"],0,"",function():void
         {
            DisplayUtil.removeForParent(typeLevel["barrier"]);
            MapManager.currentMap.makeMapArray();
            if(TasksManager.getTaskStatus(796) == TasksManager.ALR_ACCEPT)
            {
               TasksManager.getProStatusList(796,function(param1:Array):void
               {
                  if(param1[0] && !param1[1] && !showDialog)
                  {
                     Task796.onBridge();
                     showDialog = true;
                  }
               });
            }
            if(TasksManager.getTaskStatus(788) == TasksManager.ALR_ACCEPT)
            {
               TasksManager.getProStatusList(788,function(param1:Array):void
               {
                  if(param1[0] && !param1[1] && !showDialog)
                  {
                     showDialog = true;
                     Task788.onBridge();
                  }
               });
            }
            initRaft();
         });
      }
      
      override public function destroy() : void
      {
         Task1143.destroy();
         Task788.destroy();
         Task796.destroy();
         Task811.destroy();
         if(Boolean(conLevel["raftTig"]))
         {
            conLevel["raftTig"].removeEventListener(MouseEvent.CLICK,this.onRaftClick);
            ToolTipManager.remove(conLevel["raftTig"]);
         }
         if(Boolean(conLevel["raftTig1"]))
         {
            conLevel["raftTig1"].removeEventListener(MouseEvent.CLICK,this.onRaft2Click);
            ToolTipManager.remove(conLevel["raftTig1"]);
         }
         if(Boolean(conLevel["bridge"]))
         {
            conLevel["bridge"].removeEventListener(MouseEvent.CLICK,this.onBridgeClick);
            ToolTipManager.remove(conLevel["bridge"]);
         }
         if(Boolean(conLevel["sptBoss"]))
         {
            conLevel["sptBoss"].removeEventListener(MouseEvent.CLICK,this.onBossClick);
            ToolTipManager.remove(conLevel["sptBoss"]);
         }
         ToolBarController.showOrHideAllUser(true);
      }
   }
}

