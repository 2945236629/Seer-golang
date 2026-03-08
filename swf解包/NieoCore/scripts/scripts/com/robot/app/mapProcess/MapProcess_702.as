package com.robot.app.mapProcess
{
   import com.robot.app.energy.utils.EnergyController;
   import com.robot.app.spt.FightBossController;
   import com.robot.app.task.taskscollection.Task1796;
   import com.robot.app.task.taskscollection.Task887;
   import com.robot.app.task.taskscollection.Task899;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_702 extends BaseMapProcess
   {
      
      public function MapProcess_702()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.initBoss();
         Task887.initForMap702(this);
         Task899.initForMap702(this);
         SocketConnection.send(1022,86063338);
         Task1796.initTaskForMap702(this);
         getDefinitionByName("com.robot.app2.mapProcess.control.StoneTowerExploreController").initForMap702(this);
      }
      
      public function initBoss() : void
      {
         conLevel["bossStone"].gotoAndStop(1);
         conLevel["bossStone"].buttonMode = true;
         conLevel["bossStone"].addEventListener(MouseEvent.CLICK,this.showBoss);
      }
      
      public function showBoss(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         conLevel["bossStone"].buttonMode = false;
         conLevel["bossStone"].removeEventListener(MouseEvent.CLICK,this.showBoss);
         if(!e)
         {
            conLevel.addChild(conLevel["bossStone"]);
         }
         AnimateManager.playMcAnimate(conLevel["bossStone"],1,"",function():void
         {
            if(!e)
            {
               return;
            }
            NpcDialog.show(NPC.LANSITE,["我是巨石阵的守护者，如果你真的救世主，并且想拥有巨石之杖的能量，那就接受我的考验吧！"],["我想挑战你！","我先去附近看看！"],[function():void
            {
               FightBossController.fightBoss("兰斯特");
            },function():void
            {
               initBoss();
            }]);
         });
      }
      
      public function goto_704() : void
      {
         MapManager.changeMap(704);
      }
      
      public function exploitGas() : void
      {
         EnergyController.exploit(35);
      }
      
      override public function destroy() : void
      {
         conLevel["bossStone"].removeEventListener(MouseEvent.CLICK,this.showBoss);
         Task887.destroy();
         Task899.destroy();
      }
   }
}

