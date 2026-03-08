package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1839;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10386 extends BaseMapProcess
   {
      
      private var _taskMC:MovieClip;
      
      public function MapProcess_10386()
      {
         super();
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         TaskDiaLogManager.single.playStory(this.stroyLine,function():void
         {
            TaskController_1839.completeNode3();
         });
      }
      
      private function get stroyLine() : Array
      {
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HEERMOSI,["卑鄙的索伦森。竟然背后偷袭！英勇的宙斯就这样受伤了！可恶！而且黄金天马为了保护我们也受了伤。"],["你能够帮帮他们吗？"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GEMAISI,["黄金天马和宙斯是为了铲除地狱修罗这个魔头才被索伦森暗算的！希望你能够帮忙！"],["放心吧！他们的伤不成问题。"]);
         var _loc4_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         var _loc5_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DAFUNI,["太棒啦！赫拉你果然拥有超强的治愈能力！"],["我们现在就赶快回去！"]);
         var _loc6_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HEERMOSI,["对！我们赶快回去，趁索伦森元气大伤之时，彻底击败他！让他永世不得造次！嗯？创世神兵，你们怎么了？"],["并没有你想象的那么简单。"]);
         var _loc7_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.FULUODUO,["我感觉第六星系一定发生了什么事情。赫尔墨斯，你告诉我们到底怎么了？刚才出现的那个盾是不是罗慕洛？ "],["呵！可笑！"]);
         var _loc8_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         var _loc9_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HEERMOSI,["一派胡言！你们根本就不想替创世之神报仇！你们一直在拖延。你们已经被索伦森收买了吗？"],["不是的！"]);
         var _loc10_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GEMAISI,["我们只是想应该找到圣盾之灵，才拥有强大的防御能力，这样我们才能尽快的回到第六星系！索伦森不是我们的目的！"],["你们这些懦弱的家伙！"]);
         var _loc11_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,4,"mc4"]);
         var _loc12_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHENGYIZHILING,["等一等"],["随他去吧"]);
         var _loc13_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GEMAISI,["我想创世之神一定会明白我们的良苦用心。我们必须先找到圣盾之灵才会有更大的机会回到第六星系。"],["有道理！"]);
         var _loc14_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HUANGJINTIANMA,["创世神兵，你们是创世之神的武器幻化而成，定当一心为完成创世之神的遗愿而努力。"],["谢谢黄金天马的提醒！"]);
         var _loc15_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HUANGJINTIANMA,["我回到天马祭坛继续接受四神兽的试炼。希望待我实力恢复之后能够协助你们早日重返第六星系！"],["感激不尽！"]);
         var _loc16_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,5,"mc5"]);
         return [_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_,_loc15_,_loc16_];
      }
      
      private function get taskMC() : MovieClip
      {
         return conLevel["taskMC"] as MovieClip;
      }
   }
}

