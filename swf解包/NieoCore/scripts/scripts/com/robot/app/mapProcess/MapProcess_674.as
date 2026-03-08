package com.robot.app.mapProcess
{
   import com.robot.app.panel.*;
   import com.robot.app.task.taskscollection.*;
   import com.robot.app.toolBar.*;
   import com.robot.core.config.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.*;
   import com.robot.core.ui.alert.*;
   import flash.events.*;
   import flash.utils.*;
   import org.taomee.manager.*;
   
   public class MapProcess_674 extends BaseMapProcess
   {
      
      private var _color:Array = ["红","绿","蓝","紫","金"];
      
      public function MapProcess_674()
      {
         super();
      }
      
      override protected function init() : void
      {
         var t:uint = 0;
         t = 0;
         SocketConnection.send(1022,86060644);
         t = uint(setTimeout(function():void
         {
            MapNamePanel.hide();
            clearTimeout(t);
         },1000));
         topLevel.mouseEnabled = false;
         topLevel.mouseChildren = false;
         conLevel["machine"].visible = false;
         conLevel["task738_4"].visible = false;
         conLevel["diamond0"].visible = false;
         conLevel["diamond1"].visible = false;
         conLevel["diamond2"].visible = false;
         conLevel["diamond3"].visible = false;
         conLevel["diamond4"].visible = false;
         conLevel["countDown"].visible = false;
         conLevel["blood"].visible = false;
         depthLevel["littleDragon"].visible = false;
         conLevel["machine"].buttonMode = true;
         conLevel["machine"].addEventListener(MouseEvent.CLICK,this.onClickMachine);
         ToolBarController.showOrHideAllUser(false);
      }
      
      private function addTips() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            ToolTipManager.add(conLevel["diamond" + _loc1_],this._color[_loc1_] + "色龙头阵");
            conLevel["dragon" + _loc1_].visible = false;
            conLevel["dragon" + _loc1_].buttonMode = true;
            conLevel["dragon" + _loc1_].addEventListener(MouseEvent.CLICK,this.onClickDragon);
            _loc1_++;
         }
         ToolTipManager.add(conLevel["task738_4"],"铁晶石");
      }
      
      private function onClickDragon(param1:Event) : void
      {
         Alarm.show("你还没有收集到龙族宝石哦！快去附近找找铁金石，龙族宝石一定就在其中！");
      }
      
      private function onClickMachine(param1:Event) : void
      {
         SocketConnection.send(1022,86060645);
         ModuleManager.showModule(ClientConfig.getTaskModule("DragonWorldCall"),"正在打开面板",1);
      }
      
      override public function destroy() : void
      {
         ToolTipManager.remove(conLevel["task738_4"]);
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            ToolTipManager.remove(conLevel["diamond" + _loc1_]);
            conLevel["dragon" + _loc1_].removeEventListener(MouseEvent.CLICK,this.onClickDragon);
            _loc1_++;
         }
         ToolBarController.showOrHideAllUser(true);
         conLevel["machine"].removeEventListener(MouseEvent.CLICK,this.onClickMachine);
         Task738.destroy();
      }
   }
}

