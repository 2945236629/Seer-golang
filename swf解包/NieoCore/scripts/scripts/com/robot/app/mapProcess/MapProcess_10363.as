package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1801;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10363 extends BaseMapProcess
   {
      
      private var _taskMC:MovieClip;
      
      public function MapProcess_10363()
      {
         super();
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         TaskDiaLogManager.single.playStory(this.stroyLine,function():void
         {
            TaskController_1801.completeNode2();
         });
      }
      
      private function get stroyLine() : Array
      {
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.PUNI,["只怪当年我和麒麟来晚了一步，没有趁那个时候彻底消灭你这个恶魔，今天终于养成大患了。"],["话也不能这样说。"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["谱尼，我还要感谢你的及时出现给我这样强大的身躯，毕竟我们还有着某种联系。"],["那是我一生的耻辱。"]);
         var _loc4_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.PUNI,["你来太空站想干什么，我们的事情和赛尔们无关，你不要伤及无辜！"],["这也是我所想的。"]);
         var _loc5_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["我把他们骗走只不过是不想有人碍事，我今天来这里只想找你！"],["你来找我干什么？"]);
         var _loc6_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         var _loc7_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["谱尼，你的身体里还有一股更加神秘而强大的力量，我居然无法控制……"],["你想要我的力量？"]);
         var _loc8_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.PUNI,["你终究只是一个复制品，逆界之门没有那么神奇，宇宙间只会有一个谱尼！"],["你想错了。"]);
         var _loc9_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["我从不缺乏力量的来源，只是你的体内有我熟悉的力量，所以我关心的是，你的真实身份到底是什么？"],["这个你不需要知道。"]);
         var _loc10_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.PUNI,["我身上的秘密永远不会被揭开，我的一生注定会是一个谜。"],["那你这是在逼我了。"]);
         var _loc11_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         var _loc12_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["这个我可不在乎，谱尼，你准备说实话了？"],["真是卑鄙！"]);
         var _loc13_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.PUNI,["如果你觉得我是这么容易妥协的，那你就大错特错了！"],["那你能怎么办？"]);
         var _loc14_:TaskMod = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1801_3",true]);
         return [_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_];
      }
      
      private function get taskMC() : MovieClip
      {
         return conLevel["taskMC"] as MovieClip;
      }
   }
}

