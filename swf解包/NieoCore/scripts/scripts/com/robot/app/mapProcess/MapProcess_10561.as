package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_3032;
   import com.robot.app.task.control.TaskRoadOfDevildom;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10561 extends BaseMapProcess
   {
      
      public function MapProcess_10561()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         if(TasksManager.getTaskStatus(TaskRoadOfDevildom.TASK_ID_EVIL_JUMPDOWN) == TasksManager.UN_ACCEPT)
         {
            TasksManager.accept(TaskRoadOfDevildom.TASK_ID_EVIL_JUMPDOWN);
         }
         KTool.hideMapAllPlayerAndMonster();
         var _loc1_:Array = [new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,1,"mc1"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOGESI_YAOMO,["真没想到，我又回到了这里，如今我已经拥有了无穷的力量。只差正午的阳光，照耀古城之巅，我就可以统治整个宇宙了！"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOGESI_YAOMO,["所有的屈辱统统结束了，就在今日！也许天不亡我，就是给我这一次重生的机会！我要的不再是单纯的魔力，圣能，而是.....整个宇宙！！！"]),new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,2,"mc2"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.ANCIENT_ARES,["摩哥斯，我们好久不见了。"],["是你！你为什么会出现！"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOGESI_YAOMO,["这不可能！这绝对不可能！上古战神！"],["摩哥斯，没有什么不可能，从你逃走的那一刻，就应该知道今日的命运。"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.ANCIENT_ARES,["你不但没有反省自己，甚至还危害整个宇宙的安宁，据说你现在被称为“妖王”，哈哈，这个称号可比上古凶兽好听多了。"],["不要以为你现在可以打败我。"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOGESI_YAOMO,["没有任何精灵再可以击败我，宇宙中，再也没有，我突然有很多话想对你说，不过这种君临天下的感觉，想必说了你也根本不会明白。"],["或许你说得对"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.ANCIENT_ARES,["摩哥斯，现在的你，的确再无敌手。但偏偏上天还要你再经受一次考验，如果你能通过，那么连我都甘愿臣服于你。"],["什么考验？"]),new TaskMod(TaskDiaLogManager
         .DIALOG,NPC.MOGESI_YAOMO,["我已经猜到了你为什么会前来的原因，你将圣能分到X战队的体内，当我全部吸收这些能量的时候，你就会出现，哈哈！愚蠢！你以为我没有对策吗？"],["哦？看来你都已经知道了。"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.ANCIENT_ARES,["但我这次不会和你交手，因为，你的宿敌，就要出现。"]),new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,3,"mc3"]),new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_3032_1",true]),new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,4,"mc4"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.ANCIENT_ARES,["你为什么放过摩哥斯？"],["我相信他会明白"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.YELIMEISI,["摩哥斯处心积虑的想要危害宇宙，其实不过是想要获得力量。我的剑驱散了他内心的魔性，等于让他重生。"],["那么他会去哪里？"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.YELIMEISI,["暗夜城"])];
         TaskDiaLogManager.single.playStory(_loc1_,TaskController_3032.completeNode1);
      }
      
      public function get taskMc() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

