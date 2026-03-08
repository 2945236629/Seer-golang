package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NpcController;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcess_10788 extends BaseMapProcess
   {
      
      public function MapProcess_10788()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         StatManager.sendStat2014("星球活动","进入第三关场景","2015运营活动");
         KTool.getBitSet([113],function(param1:Array):void
         {
            if(!Boolean(param1[0]))
            {
               KTool.hideMapAllPlayerAndMonster();
               NpcController.npcVisible = false;
               LevelManager.iconLevel.visible = false;
               LevelManager.closeMouseEvent();
               ToolBarController.panel.hide();
               ModuleManager.hideAllModule();
               playAnimate();
            }
            else
            {
               (conLevel as MovieClip).gotoAndStop(1);
               (conLevel["pet"] as MovieClip).buttonMode = true;
               conLevel["flag"].visible = false;
            }
         });
      }
      
      private function playAnimate() : void
      {
         var mc:MovieClip = null;
         (conLevel as MovieClip).gotoAndStop(2);
         mc = conLevel["animate"] as MovieClip;
         mc.gotoAndPlay(1);
         mc.addFrameScript(mc.totalFrames - 1,function():void
         {
            mc.addFrameScript(mc.totalFrames - 1,null);
            KTool.showMapAllPlayerAndMonster(true);
            NpcController.npcVisible = true;
            LevelManager.iconLevel.visible = true;
            LevelManager.openMouseEvent();
            ToolBarController.panel.show();
            (conLevel as MovieClip).gotoAndStop(1);
            (conLevel["pet"] as MovieClip).addEventListener(MouseEvent.CLICK,onClick);
            (conLevel["pet"] as MovieClip).buttonMode = true;
            conLevel["flag"].visible = true;
         });
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("WeilltepperMainPanel",{
            "func":this.removeFlag,
            "bool":true
         });
      }
      
      private function removeFlag() : void
      {
         KTool.getBitSet([113],function(param1:Array):void
         {
            if(Boolean(param1[0]))
            {
               (conLevel as MovieClip).gotoAndStop(1);
               conLevel["flag"].visible = false;
            }
         });
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}

