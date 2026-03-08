package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1970;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10477 extends BaseMapProcess
   {
      
      public function MapProcess_10477()
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
         super.init();
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SAIXIAOXI,["尤曼斯说曾经海盗集团到达过他们的城堡，所以很有可能地祇灵石在海盗集团的手里！ "],["地祇灵石？"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KALULU,["我们曾经在魔窟之门的麦康纳那里得到过地祇灵珠！没想到还有地祇石！"],["现在还不知道到底怎么回事！"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SAIXIAOXI,["但是尤曼斯指示的是海盗集团，我相信这里一定会有线索！ "],["那看一看吧！"]);
         mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KETANA,["可恶！又是你，创世兵魂！你处处与我们做对，我不会放过你的！"],["哼！你们不会得逞的！"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.CHUANGSIBINGHUN,["回去告诉奥罗纳尔，不管你们天魔组织多么强大，有我在，你们都不可能成功！"],["可恶！"]);
         mod8 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.TEMENGLE,["不要自以为是，只要海盗研究所将地祇灵石成功镶嵌在地狱兽身体里，你们统统都会被消灭！"],["什么？地祇石？"]);
         mod9 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["地祇石镶嵌在地狱兽身体里？坏了！我们绝对不能让他们成功！"],["小心！"]);
         mod10 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9,mod10],function():void
         {
            TaskController_1970.completeNode3();
         });
      }
      
      public function get taskMC() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

