package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.BitBuffSetClass;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.SystemTimerManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcController;
   import com.robot.core.npc.NpcDialog;
   import com.robot.core.utils.CommonUI;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcess_10784 extends BaseMapProcess
   {
      
      private var _currentSec:int;
      
      private const PLAY_SEQ:Array = [1,2,0,3];
      
      public function MapProcess_10784()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         StatManager.sendStat2014("星球活动","进入第二关场景","2015运营活动");
         conLevel["gate"].buttonMode = true;
         conLevel["gate"].addEventListener(MouseEvent.CLICK,this.onDeviceClicked);
         topLevel["brokenMc"].visible = false;
         CommonUI.addYellowExcal(topLevel,615,132);
         this._currentSec = 0;
         SystemTimerManager.addTickFun(this.onCount);
      }
      
      private function onCount() : void
      {
         ++this._currentSec;
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            conLevel["circle_" + _loc1_].gotoAndStop(1);
            _loc1_++;
         }
         switch(this._currentSec)
         {
            case 1:
            case 2:
            case 3:
            case 4:
               conLevel["circle_" + this.PLAY_SEQ[this._currentSec - 1]].gotoAndStop(2);
               break;
            default:
               if(this._currentSec >= 7)
               {
                  this._currentSec = 0;
               }
         }
      }
      
      private function onDeviceClicked(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         switch(_loc2_)
         {
            case "gate":
               StatManager.sendStat2014("星球活动","点击第二关石门","2015运营活动");
               CommonUI.removeYellowExcal(topLevel);
               ModuleManager.showAppModule("WeilltepperCirclePanel",{
                  "playSeq":this.PLAY_SEQ,
                  "fun":this.refresh
               });
         }
      }
      
      private function refresh(param1:Boolean = false) : void
      {
         var mc:MovieClip = null;
         var hasCompleted:Boolean = param1;
         if(hasCompleted)
         {
            KTool.hideMapAllPlayerAndMonster();
            NpcController.npcVisible = false;
            LevelManager.iconLevel.visible = false;
            LevelManager.closeMouseEvent();
            ToolBarController.panel.hide();
            ModuleManager.hideAllModule();
            mc = topLevel["brokenMc"] as MovieClip;
            mc.visible = true;
            mc.gotoAndPlay(1);
            mc.addFrameScript(mc.totalFrames - 1,function():void
            {
               mc.addFrameScript(mc.totalFrames - 1,null);
               mc.visible = false;
               KTool.showMapAllPlayerAndMonster(true);
               NpcController.npcVisible = true;
               LevelManager.iconLevel.visible = true;
               LevelManager.openMouseEvent();
               ToolBarController.panel.show();
               NpcDialog.show(NPC.XIAOSAIER,["四周传来了一阵机关声，好像有什么机关被打开了。"],[""],[function():void
               {
                  NpcDialog.show(NPC.XIAOSAIER,["出现了一个传送阵！看来这一关通过了，我离魔王又近了一步！"],[""],[function():void
                  {
                     if(BitBuffSetClass.getState(22612) == 0)
                     {
                        BitBuffSetClass.setState(22612,1);
                     }
                     MapManager.changeMap(10788);
                  }]);
               }]);
            });
         }
      }
      
      override public function destroy() : void
      {
         conLevel["gate"].buttonMode = false;
         conLevel["gate"].removeEventListener(MouseEvent.CLICK,this.onDeviceClicked);
         SystemTimerManager.removeTickFun(this.onCount);
         super.destroy();
      }
   }
}

