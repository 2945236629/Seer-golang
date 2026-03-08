package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.BitBuffSetClass;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcController;
   import com.robot.core.npc.NpcDialog;
   import com.robot.core.utils.CommonUI;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcess_10783 extends BaseMapProcess
   {
      
      private var _shootCount:int;
      
      public function MapProcess_10783()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         StatManager.sendStat2014("星球活动","进入第一关场景","2015运营活动");
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            conLevel["tower_" + _loc1_].buttonMode = true;
            conLevel["tower_" + _loc1_].addEventListener(MouseEvent.CLICK,this.onDeviceClicked);
            _loc1_++;
         }
         conLevel["gate"].buttonMode = true;
         conLevel["gate"].addEventListener(MouseEvent.CLICK,this.onDeviceClicked);
         CommonUI.addYellowExcal(conLevel,615,132);
         topLevel["brokenMc"].visible = false;
      }
      
      private function onDeviceClicked(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         var _loc3_:int = this.getIndex(param1.currentTarget);
         switch(_loc2_)
         {
            case "gate":
               StatManager.sendStat2014("星球活动","点击第一关石门","2015运营活动");
               CommonUI.removeYellowExcal(topLevel);
               ModuleManager.showAppModule("WeilltepperMainPanel");
               break;
            default:
               if(_loc2_.indexOf("tower_") >= 0)
               {
                  ModuleManager.showAppModule("WeilltepperShootPanel",{
                     "index":_loc3_,
                     "fun":this.refresh
                  });
               }
         }
      }
      
      private function refresh(param1:int) : void
      {
         var mc:MovieClip = null;
         var index:int = param1;
         if(index >= 0)
         {
            ++this._shootCount;
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
               conLevel["tower_" + index].gotoAndStop(1);
               CommonUI.setEnabled(conLevel["tower_" + index],false,true);
               CommonUI.setEnabled(conLevel["dot_" + index],false,true);
               NpcDialog.show(NPC.XIAOSAIER,["四周传来了一阵机关声，好像有什么机关被打开了。"],[""],[function():void
               {
                  if(_shootCount >= 4)
                  {
                     NpcDialog.show(NPC.XIAOSAIER,["出现了一个传送阵！看来这一关通过了，我离魔王又近了一步！"],[""],[function():void
                     {
                        if(BitBuffSetClass.getState(22611) == 0)
                        {
                           BitBuffSetClass.setState(22611,1);
                        }
                        MapManager.changeMap(10784);
                     }]);
                  }
               }]);
            });
         }
      }
      
      private function getIndex(param1:Object) : int
      {
         var _loc2_:String = param1.name;
         var _loc3_:Array = _loc2_.split("_");
         return _loc3_[1] == null ? -1 : int(_loc3_[1]);
      }
      
      override public function destroy() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            conLevel["tower_" + _loc1_].buttonMode = false;
            conLevel["tower_" + _loc1_].removeEventListener(MouseEvent.CLICK,this.onDeviceClicked);
            _loc1_++;
         }
         conLevel["gate"].buttonMode = false;
         conLevel["gate"].removeEventListener(MouseEvent.CLICK,this.onDeviceClicked);
         super.destroy();
      }
   }
}

