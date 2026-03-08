package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.events.MouseEvent;
   
   public class MapProcess_11375 extends BaseMapProcess
   {
      
      public function MapProcess_11375()
      {
         super();
      }
      
      override protected function init() : void
      {
         MapListenerManager.add(conLevel["npc"],this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         TaskDiaLogManager.single.playStory(this.dialogArr,function():void
         {
            MapManager.changeMapWithCallback(11376);
         });
      }
      
      private function get dialogArr() : Array
      {
         var _loc4_:TaskMod = null;
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.XIAO_CROW,["你好啊，小赛尔。"],["不好意思，我迷路了。请问圣战之巅怎么走？"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.XIAO_CROW,["你去那里，是要瞻仰英雄的雕像吧！"],["不是，我是帮一个朋友送点东西。"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.XIAO_CROW,["哦？难道你送的是药剂吗？"],["对呀，你怎么知道。"]);
         _loc4_ = new TaskMod(TaskDiaLogManager.DIALOG,NPC.XIAO_CROW,["我大概知道是谁了，我送你去吧，小赛尔。"],["谢谢你！"]);
         _loc1_.isNewDialog_1 = true;
         _loc2_.isNewDialog_1 = true;
         _loc3_.isNewDialog_1 = true;
         _loc4_.isNewDialog_1 = true;
         return [_loc1_,_loc2_,_loc3_,_loc4_];
      }
      
      override public function destroy() : void
      {
         KTool.showMapAllPlayerAndMonster();
         super.destroy();
      }
   }
}

