package com.robot.app.mapProcess
{
   import com.robot.app.panel.MapNamePanel;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alarm2;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.events.SocketEvent;
   
   public class MapProcess_11350 extends BaseMapProcess
   {
      
      private var count:int;
      
      public function MapProcess_11350()
      {
         super();
      }
      
      override protected function init() : void
      {
         conLevel.addEventListener(MouseEvent.CLICK,this.onClick);
         this.show();
      }
      
      private function show() : void
      {
         animatorLevel.visible = false;
         MapNamePanel.hide();
         ToolBarController.panel.hide();
         LevelManager.iconLevel.visible = false;
         KTool.getMultiValue([5386],function(param1:Array):void
         {
            var _loc2_:int = 0;
            while(_loc2_ < 6)
            {
               if(KTool.getBit(param1[0],_loc2_ + 1) > 0)
               {
                  conLevel["mc_" + _loc2_].visible = false;
                  ++count;
               }
               _loc2_++;
            }
            conLevel["numTxt"].text = count + "/6";
            if(count >= 6)
            {
               yiQi();
            }
         });
      }
      
      public function onClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         var index:int = int(e.target.name.split("_")[1]);
         switch(e.target.name)
         {
            case "mc_" + index:
               this.stoneClick(index);
               break;
            case "close":
               MapManager.changeMapWithCallback(1,function():void
               {
                  ModuleManager.showAppModule("ChuanChengQuestionPanel");
               });
         }
      }
      
      public function stoneClick(param1:int) : void
      {
         var index:int = param1;
         SocketConnection.sendWithCallback(43200,function(param1:SocketEvent):void
         {
            var e:SocketEvent = param1;
            Alarm2.show("恭喜你采集到1个电能石");
            KTool.getMultiValue([5386],function(param1:Array):void
            {
               count = 0;
               var _loc2_:int = 0;
               while(_loc2_ < 6)
               {
                  if(KTool.getBit(param1[0],_loc2_ + 1) > 0)
                  {
                     conLevel["mc_" + _loc2_].visible = false;
                     ++count;
                  }
                  _loc2_++;
               }
               conLevel["numTxt"].text = count + "/6";
               if(count >= 6)
               {
                  yiQi();
               }
            });
         },6,index + 1);
      }
      
      public function yiQi() : void
      {
         animatorLevel.visible = true;
         conLevel.visible = false;
         AnimateManager.playMcAnimate(animatorLevel as MovieClip,1,"mc",function():void
         {
            animatorLevel.visible = false;
            conLevel.visible = true;
            MapManager.currentMap.depthLevel.visible = true;
            MapManager.changeMapWithCallback(1,function():void
            {
               ModuleManager.showAppModule("ChuanChengQuestionPanel");
            });
         });
      }
      
      override public function destroy() : void
      {
         KTool.showMapAllPlayerAndMonster(true);
         ToolBarController.showOrHideAllUser(true);
         LevelManager.iconLevel.visible = true;
         ToolBarController.panel.show();
         MapNamePanel.show();
         MainManager.selfVisible = true;
         super.destroy();
      }
   }
}

