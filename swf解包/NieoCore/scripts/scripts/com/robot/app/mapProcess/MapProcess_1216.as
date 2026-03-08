package com.robot.app.mapProcess
{
   import com.robot.app.petbag.PetBagControllerNew;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.PetManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.ui.alert.Alarm2;
   
   public class MapProcess_1216 extends BaseMapProcess
   {
      
      private var _numCollect:int = 0;
      
      public function MapProcess_1216()
      {
         super();
      }
      
      override protected function init() : void
      {
         MapListenerManager.add(conLevel["goOut"],this.onClick);
         MapListenerManager.add(conLevel["pack"],this.onClick);
         MapListenerManager.add(conLevel["cure"],this.onClick);
         ToolBarController.panel.hide();
         LevelManager.iconLevel.visible = false;
         this.fresh();
      }
      
      private function fresh() : void
      {
         KTool.getMultiValue([13234],function(param1:Array):void
         {
            var arr:Array = param1;
            _numCollect = arr[0];
            conLevel["txt"].text = _numCollect + "/5";
            if(_numCollect >= 5)
            {
               Alarm2.show("恭喜你！你已经完成任务。",function():void
               {
                  MapManager.changeMapWithCallback(1,function():void
                  {
                     ModuleManager.showAppModule("AllChaseAnheishenshouTaskPanel");
                  });
               });
            }
         });
      }
      
      private function onClick(param1:* = null) : void
      {
         var e:* = param1;
         switch(e.target.name)
         {
            case "goOut":
               MapManager.changeMapWithCallback(1,function():void
               {
                  ModuleManager.showAppModule("AllChaseAnheishenshouTaskPanel");
               });
               break;
            case "pack":
               PetBagControllerNew.showByBuffer();
               break;
            case "cure":
               PetManager.cureAllFree();
         }
      }
      
      override public function destroy() : void
      {
         ToolBarController.panel.show();
         LevelManager.iconLevel.visible = true;
         super.destroy();
      }
   }
}

