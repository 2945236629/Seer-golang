package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1973;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10481 extends BaseMapProcess
   {
      
      public function MapProcess_10481()
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
         var mod12:TaskMod;
         var mod13:TaskMod;
         var mod14:TaskMod;
         super.init();
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["发生了什么事情？为什么巧克利的表情全都这么严肃！"],["我们不喜欢他！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.QIAOKELI,["自从卡修斯出现之后，怀特星就再也没有平静过！他就是诅咒之子！"],["你们不能这样说！"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.QIAOKELI,["为什么不能？怀特星不欢迎他！怀特星不欢迎被诅咒的怪物！"],["你们太过分了！"]);
         mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.AOLUONAER,["看到了吧！那就是卡修斯的精元，地狱兽，接下来看你的了！"],["地狱兽？"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["海盗集团研制成功了？糟了，这下想要对抗他们变得更加困难了！"],["知道就好！"]);
         mod8 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DIYUSHOU,["什么战神联盟，什么圣神禁地的守护者，统统都该结束了！卡修斯，灭亡吧！"],["不要！！！"]);
         mod9 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         mod10 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DIYUSHOU,["不要做无谓的抵抗了！我体内拥有魔石能量与卡修斯超进化的能量，就凭你们！哼！"],["可恶！"]);
         mod11 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["就算是战斗到最后一刻，我都不会放弃的！赛尔，永不服输！"],["是吗？还真是倔强！"]);
         mod12 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DIYUSHOU,["卡修斯，灭亡吧！不管是圣神禁地的守护者还是诅咒之子，就在今天，结束了！哈哈哈！"],["太自大了吧！"]);
         mod13 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1973_1",true]);
         mod14 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,4,"mc4"]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9,mod10,mod11,mod12,mod13,mod14],function():void
         {
            TaskController_1973.completeNode3();
         });
      }
      
      public function get taskMC() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

