package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1962;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10463 extends BaseMapProcess
   {
      
      public function MapProcess_10463()
      {
         super();
      }
      
      override protected function init() : void
      {
         var mod1:TaskMod;
         var mod2:TaskMod;
         var mod3:TaskMod;
         var mod4:TaskMod;
         var mod6:TaskMod;
         var mod7:TaskMod;
         var mod8:TaskMod;
         var mod88:TaskMod;
         var mod89:TaskMod;
         var mod9:TaskMod;
         var mod10:TaskMod;
         super.init();
         if(TasksManager.getTaskStatus(1962) == TasksManager.UN_ACCEPT)
         {
            TasksManager.accept(1962);
         }
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHIPER,["卡修斯一定能够冲破重重难关，成功超进化的！只可惜，到现在我们都没能找到赛小息！   "],["船长，不要担心！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.JUSTIN,["近期赛尔飞船正在全力搜索赛小息的行踪！一旦发现，立即前往营救！确保赛小息平安归来！"],["一定要找到他啊！"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["都怪我们，没有保护好赛小息！  "],["我回来啦！"]);
         mod6 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SAIXIAOXI,["我发现索伦森依靠着魔石能量，实力变得异常强大！而背后强大的支持者就是奥罗纳尔！"],["奥罗纳尔？"]);
         mod8 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["就是控制住卡修斯的那个邪恶的精灵吗？"],["是的！就是他"]);
         mod88 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SAIXIAOXI,["船长，我已经找到了他们的线索！让我和先锋队一起去剿灭他们，救出卡修斯！决不能容忍他们为非作歹！"],["可是……"]);
         mod89 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SAIXIAOXI,["船长！放心吧！我没事的！有大家跟我一起，我们一定能够凯旋而归的！"],["我们跟你一起！"]);
         mod9 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         mod10 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1962_11",true]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod6,mod7,mod8,mod88,mod89,mod9,mod10],function():void
         {
            TaskController_1962.completeNode1();
         });
      }
      
      public function get taskMC() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

