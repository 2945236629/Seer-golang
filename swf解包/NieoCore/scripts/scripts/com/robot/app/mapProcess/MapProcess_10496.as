package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1987;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10496 extends BaseMapProcess
   {
      
      public function MapProcess_10496()
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
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DIYUSHOU,[MainManager.actorInfo.formatNick + "真是胆识过人啊！竟然敢自己一个来到德拉诺荒漠！既然来了，就走不掉了！"],["怎么办！怎么办！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["以前身边总是有精灵陪伴！举世无双的创世兵魂！威力巨大的尤曼斯！结果现在身边就只有我一个人！这次在劫难逃了！"],["哼！小赛尔，乖乖投降吧！"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DIYUSHOU,["听从魔灵王的指令，去赛尔飞船把所有的资料都偷出来，说不定我会饶过你！"],["你休想！"]);
         mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,2,"mc2"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DIYUSHOU,["呵！没想到传说中的天蛇星少主也不过如此！"],["哼！可恶的魔石精灵！"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MIUSI,["你们不过是依靠着魔石提供自己强大的能量！即使是战胜我也胜之不武，何况你根本没有战胜我！弱者！"],["可恶！一定要让你尝尝失败的滋味！"]);
         mod8 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,3,"mc3"]);
         mod9 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["缪斯少主！威武！威武！哼！可恶的地狱兽尝到失败者的滋味了吧！"],["失败？哈哈！"]);
         mod10 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DIYUSHOU,["从我第一次接受魔石能量进入我身体的时候，我就不知道什么叫做失败！我可不像耶里梅斯一样，自取灭亡！"],["你说什么？"]);
         mod11 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MIUSI,["你怎么会认识我哥哥？他在哪里？为什么说他自取灭亡？"],["我是不会告诉你的！去问你的好伙伴——布莱克吧！"]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9,mod10,mod11],function():void
         {
            TaskController_1987.completeNode3();
         });
      }
      
      public function get taskMc() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

