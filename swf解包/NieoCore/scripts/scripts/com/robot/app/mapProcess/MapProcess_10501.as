package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1992;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10501 extends BaseMapProcess
   {
      
      public function MapProcess_10501()
      {
         super();
      }
      
      override protected function init() : void
      {
         var mod1:TaskMod;
         var mod2:TaskMod;
         var mod3:TaskMod;
         var mod4:TaskMod;
         var mod5:TaskMod;
         var mod6:TaskMod;
         var mod7:TaskMod;
         var mod8:TaskMod;
         var mod9:TaskMod;
         var mod10:TaskMod;
         var mod11:TaskMod;
         super.init();
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DIFULIEN,["太棒啦！我拥有炫彩山的绝世能量——山岳石！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KAIERSASI,["我拥有星神境地的无垠能量——天神石！"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["我和尤曼斯找到了魔窟之门的大地之能——地祇石！"],["那刚好！"]);
         mod5 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHILAIMU_KING,["我带来了永恒之树的上古秘石——永恒石！"],["太棒啦！"]);
         mod6 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1992_0",true]);
         mod7 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,2,"mc2"]);
         mod8 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["成功啦！成功啦！卡修斯回来了！我们的卡修斯回来！"],["太棒了！"]);
         mod9 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHILAIMU_KING,["史莱姆一族的使命，终于达成了！我要去照看我的子民们！"]);
         mod10 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KAIERSASI,["星神的任务也顺利完成了！我该回去复命了！"],["太棒啦！卡修斯回来了！"]);
         mod11 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,3,"mc3"]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9,mod10,mod11],function():void
         {
            TaskController_1992.completeNode2();
         });
      }
      
      public function get taskMc() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

