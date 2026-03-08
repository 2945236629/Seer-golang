package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.BitBuffSetClass;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NpcDialogNew_1;
   import com.robot.core.ui.alert.Alarm;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MapProcess_11764 extends BaseMapProcess
   {
      
      private var m_Index:int;
      
      private var m_value:int;
      
      private var totalNum:int;
      
      private var hasNum:int;
      
      private var lastPos:Point;
      
      private var objP:Point;
      
      private var objP1:Point;
      
      private var initPos:Point;
      
      public function MapProcess_11764()
      {
         super();
      }
      
      override protected function init() : void
      {
         LevelManager.iconLevel.visible = false;
         ToolBarController.panel.visible = true;
         MainManager.actorInfo.mapID = 11764;
         conLevel.addEventListener(MouseEvent.CLICK,this.onConClick1);
         this.initPos = new Point(454,469);
         this.objP = new Point();
         this.objP.x = conLevel["door_1"].x;
         this.objP.y = conLevel["door_1"].y;
         MainManager.actorModel.pos = this.initPos.clone();
         this.update();
         MainManager.actorModel.addEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
         if(BitBuffSetClass.getState(23703) == 0)
         {
            this.stopPlaying();
            BitBuffSetClass.setState(23703,1);
            return;
         }
      }
      
      public function update(param1:* = null) : void
      {
         var e:* = param1;
         KTool.getMultiValue([104641],function(param1:Array):void
         {
            var i:int;
            var arr:Array = param1;
            m_value = arr[0] & 0x0F;
            m_Index = arr[0];
            i = 15;
            while(i <= 19)
            {
               if(KTool.getBit(arr[0],i) == 1)
               {
                  conLevel["Branch_" + (i - 14)].visible = false;
               }
               else
               {
                  conLevel["Branch_" + (i - 14)].visible = true;
               }
               i++;
            }
            if(m_value == 4)
            {
               NpcDialogNew_1.show(3031,["好了，我想应该足够了。我们不能一直在外面乱晃，赶紧回到遗迹去吧！"],["嗯！"],[function():void
               {
               }]);
            }
         });
      }
      
      public function onConClick1(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         var index:int = int(e.target.name.split("_")[1]);
         switch(e.target.name)
         {
            case "Branch_" + index:
               SocketConnection.sendByQueue(43305,[18,3 + index],function(param1:*):void
               {
                  Alarm.show("你采集了一根藤条。");
                  update();
               });
               break;
            case "door_1":
               MapManager.changeMap(11763);
         }
      }
      
      private function stopPlaying() : void
      {
         NpcDialogNew_1.show(3032,["就是这里了！看到那些藤条没，快把它们都扯下来！"],null,null,false,function():void
         {
         });
      }
      
      public function onWalkEnter(param1:RobotEvent) : void
      {
      }
      
      override public function destroy() : void
      {
         LevelManager.iconLevel.visible = true;
         MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
         conLevel.removeEventListener(MouseEvent.CLICK,this.onConClick1);
         ToolBarController.panel.visible = true;
      }
   }
}

