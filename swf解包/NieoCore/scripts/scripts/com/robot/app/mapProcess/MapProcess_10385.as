package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1839;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10385 extends BaseMapProcess
   {
      
      private var _taskMC:MovieClip;
      
      public function MapProcess_10385()
      {
         super();
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         TaskDiaLogManager.single.playStory(this.stroyLine,function():void
         {
            TaskController_1839.completeNode2();
         });
      }
      
      private function get stroyLine() : Array
      {
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HEERMOSI,["索伦森！没想到你这么卑鄙！为了治愈自己的伤势，竟然不顾宇宙的能量平衡！"],["好一副正人君子的义愤填膺！"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["当初你们神域天王又何尝不是这样做的！不然我又为何来到这里。这个世界本来就是你争我夺的成王败寇！这可是你们教我的！"],["一派胡言！"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HEERMOSI,["创世神兵，是时候了结创世之神的恩怨了。让我们联手，一起解决这个作恶多端的魔头！"],["创世神兵你们要想好。"]);
         var _loc4_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["只要你们回到第六星系一切都会明白！我不希望我们之间再产生什么恩怨！不过想要趁火打劫我无所谓。让你们见识一下什么才是真正的星系之源！"],["你暗算创世之神，不可饶恕！"]);
         var _loc5_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         var _loc6_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HUANGJINTIANMA,["索伦森，第六星系的事情我希望你们回到自己的星系去解决。不要影响其他星系的能量平衡。不然一旦造成宇宙失去平衡，最终会有重大的灾难发生！"],["重大灾难？"]);
         var _loc7_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["重大灾难？重大灾难有多大？会比自己的家族亲人被驱逐被屠杀更大吗？你们根本什么都不懂！"],["你说什么？"]);
         var _loc8_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HEERMOSI,["你觉得你这样无节制的掠夺各星系的能源还有道理了？星系的叛徒，根本就不应该存在这里！"],["哼！不自量力！"]);
         var _loc9_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         var _loc10_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DIYUXIULUO,["有我在这里！休要放肆！"],["地狱修罗？"]);
         var _loc11_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["哈哈哈！不愧为我的得力干将！消灭他们！让他们彻底消失！就用他们来祭奠我们曾经逝去的亲人！"],["索伦森不要任意妄为。"]);
         var _loc12_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HUANGJINTIANMA,["当年我前往第六星系的时候，明明是一派生机。创世之神乃宅心仁厚之人，为什么会让你们如此憎恨？"],["那是你被蒙蔽了双眼！"]);
         var _loc13_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["我不想多说！这一切应该去问问你旁边的这个梦境之神呢！地狱修罗，与我们一起解决他们！我们共享六大星系！"],["暴露了你的狼子野心！"]);
         var _loc14_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HEERMOSI,["神域四天王是不允许有谁来破坏整个星系的平衡的！我们当初就应该直接解决你这个祸害。 "],["那就来吧！"]);
         var _loc15_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         var _loc16_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ZHOUSI,["地狱修罗！我不会再让你这个恶魔出现在世上。永远沉睡在地底吧！ "],["那看你有没有本事！"]);
         var _loc17_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DIYUXIULUO,["既然让我苏醒，那么就休想再把我封印。你还没有尝过权力的滋味吧？把整个星系的精灵都操控在手里的滋味真是太棒了！ "],["够了！"]);
         var _loc18_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ZHOUSI,["你这个恶魔！今天就将你埋葬在这里！ "],["恶魔？赫尔墨斯才是恶魔！"]);
         var _loc19_:TaskMod = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1839_1",true]);
         var _loc20_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HEERMOSI,["就趁现在！创世神兵，让我们一起把魔君消灭，了结创世之神的恩怨！ "],["就凭你们吗？"]);
         var _loc21_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["创世神兵，不要听信赫尔墨斯的谗言！ "],["勿需多言！"]);
         var _loc22_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,4,"mc4"]);
         return [_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_,_loc15_,_loc16_,_loc17_,_loc18_,_loc19_,_loc20_,_loc21_,_loc22_];
      }
      
      private function get taskMC() : MovieClip
      {
         return conLevel["taskMC"] as MovieClip;
      }
   }
}

