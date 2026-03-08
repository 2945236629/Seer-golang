package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1713;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10342 extends BaseMapProcess
   {
      
      public function MapProcess_10342()
      {
         super();
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         TaskDiaLogManager.single.playStory(this.storyLine,function():void
         {
            TaskController_1713.completeNode2();
         });
      }
      
      protected function get storyLine() : Array
      {
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.BOSIDIJIA,["玛法里奥你终于重生了，这样迈迪文和博拉纳的牺牲也算有价值了……"],["牺牲？他们为我牺牲了？"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["我以为我已经彻底与这个世界告别了，没有想到还能有重生的一天。"],["我们需要你玛法里奥！"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.BOSIDIJIA,["现在索伦森马上就要拿战神联盟献祭，打开逆界之门降临了，如今只有你能去阻止他了！"],["索伦森？好熟悉的名字。"]);
         var _loc4_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,1,"mc1"]);
         var _loc5_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["我感觉好多了，既然当初是我闯下的祸，我拼尽全力也会去弥补！"],["恩，我们一起去努力！"]);
         var _loc6_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.BOSIDIJIA,["这样才对得起迈迪文和博拉纳的牺牲，我们决不能让索伦森降临！"],["哎，都是我害了他们。"]);
         var _loc7_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["当时我拼死阻挡住索伦森，担心今后他还会出来，正巧迈迪文他们出现，我就把剩余的力量传输给了他们，还重新灌输了记忆让他们永远守护逆界之门。"],["确实是机缘巧合。"]);
         var _loc8_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.BOSIDIJIA,["没想到一次偶然永远改变了他们的命运……不过他们足够勇敢，足够坚定，没有辜负你赋予他们的使命！"],["那本是我的使命。"]);
         var _loc9_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,2,"mc2"]);
         return [_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_];
      }
      
      private function get taskMc() : MovieClip
      {
         return conLevel["taskMc"];
      }
   }
}

