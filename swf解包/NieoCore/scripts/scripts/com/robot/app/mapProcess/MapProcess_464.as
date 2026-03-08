package com.robot.app.mapProcess
{
   import com.robot.app.mapProcess.control.*;
   import com.robot.app.spt.*;
   import com.robot.app.task.taskscollection.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.*;
   import flash.utils.*;
   import org.taomee.manager.*;
   
   public class MapProcess_464 extends BaseMapProcess
   {
      
      public static var hasTaskInteractOver:Boolean;
      
      private var cls:*;
      
      public function MapProcess_464()
      {
         super();
      }
      
      override protected function init() : void
      {
         hasTaskInteractOver = true;
         conLevel["task845Tig"].visible = false;
         conLevel["trees_mc"].visible = false;
         conLevel["katuMc"].visible = false;
         conLevel["card_btn"].visible = false;
         Task845.initTaskForMap464(this);
         Task568.initTask_464(this);
         Task570.initTask_464(this);
         MP464Helper.setup(this);
         Task572.initTask_464(this);
         this.initNpc();
         Task850.initTaskForMap464(this);
      }
      
      private function initNpc() : void
      {
         ToolTipManager.add(depthLevel["spt"],"阿加莎");
         depthLevel["spt"].buttonMode = true;
         depthLevel["spt"].addEventListener(MouseEvent.CLICK,this.onSptClick);
      }
      
      private function onSptClick(param1:MouseEvent) : void
      {
         getDefinitionByName("com.robot.app2.control.DeepseaLightWarriorController").setup();
         FightBossController.fightBoss("阿加莎");
      }
      
      override public function destroy() : void
      {
         ToolTipManager.remove(depthLevel["spt"]);
         depthLevel["spt"].removeEventListener(MouseEvent.CLICK,this.onSptClick);
         Task570.destory();
         Task568.destory();
         Task845.destory();
         MP464Helper.destroy();
      }
   }
}

