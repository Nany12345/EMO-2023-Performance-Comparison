function [Subset,selInd] = LGIHSS(PopObj,selNum,ref)
    a = size(PopObj, 1);
    M = size(PopObj, 2);
    selectedPop = [];
    selInd = [];
    
    if a<=selNum
       Subset=PopObj; 
    else
        %% heap initialization
        heap.size=0;
        heap.index=[];
        heap.hvc=[];
        %% get the HVC of all unselected solutions at the first iteration 
        for n = 1 : a
           heap.index(n) = n; 
           currentPop = [selectedPop;PopObj(n,:)];
           heap.hvc(n) = HVC(currentPop,ref,size(currentPop,1));
           heap.size = heap.size +1;       
        end
           
        si = heap.size; % si is the number of all unselected solutions
        while(si >= 1)
            heap = heap_down_sink(si,heap);
            si = si-1;
        end
        %% Select first solution
        top = heap.index(1);
        selInd = [selInd,top];
        selectedPop = [selectedPop;PopObj(top,:)];
        heap = min_heap_popup(heap);
        
        %% Select other solutions
        while size(selectedPop,1)<selNum
            %size(selectedPop, 1) 
            while true
                last_index = heap.index(1);
                top = heap.index(1);
                currentPop = [selectedPop;PopObj(top,:)];
                heap.hvc(1) = HVC(currentPop,ref,size(currentPop,1));
                heap = heap_down_sink(1, heap);
                if(heap.index(1) == last_index)            
                    selectedPop = [selectedPop;PopObj(heap.index(1),:)];
                    selInd = [selInd,heap.index(1)];
                    heap = min_heap_popup(heap);
                    break;  
                end
            end
        end
        %% output 
        Subset = selectedPop;
    end
end

function Score = HVC(Population,RefPoint,index)
    data = Population;
    data1 = data;
    s = data1(index,:);
    data1(index,:)=[];
    data1 = max(s,data1);       
    Score = prod(RefPoint-s)-stk_dominatedhv(data1,RefPoint); 
end

function heap = heap_down_sink(self,heap)
    lchild =self*2;
    rchild =self*2+1;
    if(lchild <= heap.size && rchild <= heap.size)
        if(heap.hvc(self) < heap.hvc(lchild) || heap.hvc(self) < heap.hvc(rchild))
            if(heap.hvc(lchild) >= heap.hvc(rchild))
                heap = heap_swap_node(lchild,self,heap);
                heap = heap_down_sink(lchild, heap);
            else
                heap = heap_swap_node(rchild,self, heap);
                heap = heap_down_sink(rchild, heap);
            end
        end
    elseif(lchild <= heap.size)
        if(heap.hvc(self) < heap.hvc(lchild))
            heap = heap_swap_node(lchild,self, heap);
        end
    end
end

function heap = heap_swap_node(node1,node2, heap)
%     heap.index(node1)
%     heap.index(node2)
    t_index = heap.index(node1);
    t_hvc = heap.hvc(node1);
    
    heap.index(node1) = heap.index(node2);
    heap.hvc(node1) = heap.hvc(node2);

    heap.index(node2) = t_index;
    heap.hvc(node2) = t_hvc;
    
%     heap.index(node1)
%     heap.index(node2)
    
end


function heap = min_heap_popup(heap)
    heap = heap_swap_node(1,heap.size, heap);
    heap.size =heap.size-1;
    heap = heap_down_sink(1,heap);
end

